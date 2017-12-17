extends KinematicBody2D

export var instance_name = "Player"
export (String) var team_group_name
export var player_speed = 170

var station_manager
var scrap_inventory
var active_station
var selected_scrap_to_drop

# This is physics shit
const FLOOR_NORMAL = Vector2(0, -1)
const ACCELERATION = 0.8

var velocity = Vector2()

# Variables related to shooting
var shooting_timer 
var menu_timer
var can_shoot = true

# Damage receiver
var shocked = false
var shocked_timer

onready var area       = get_node("Area2D")
onready var controller = get_node("ControllerInput")
onready var scrap_selection_menu = get_node("ScrapSelectionMenu")

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	_init_scrap_inventory()
	_init_station_active_flags()
	_connect_to_signals()
	_print_debug_info()
	
	controller.connect("button_pressed", self, "_on_button_pressed")

	shooting_timer = TimerGenerator.create_timer(Constants.PLAYER_FIRE_RATE, "_enable_shooting", self)
	shooting_timer.set_autocancel(false)

	shocked_timer = TimerGenerator.create_timer(Constants.PLAYER_FIRE_RATE, "_remove_shock", self)
	shocked_timer.set_autocancel(false)

func _fixed_process(delta):
	_handle_movement(delta)
	if (scrap_selection_menu != null):
		scrap_selection_menu.set_pos(get_pos() + Vector2(0, -60))

func set_scrap_selection_menu(menu):
	scrap_selection_menu = menu
	_init_scrap_selection_menu()

func _enable_shooting():
	can_shoot = true

func _remove_shock():
	shocked = false

func _on_button_pressed(action):
	if shocked: return
	if action == "action_drop":
		if active_station == "power_up_station":
			_show_scrap_menu()
			_drop_scraps_to_power_up_station()
		elif active_station == "economy_station":
			_show_scrap_menu()
			_drop_scraps_to_economy_station()
	if action == "action_primary" && is_move_and_slide_on_floor():
		velocity.y -= Constants.PLAYER_JUMP_FORCE
	elif action == "action_shoot":
		if can_shoot:
			var player_bullet = load("res://Elements/PlayerBullet.tscn").instance()
			player_bullet.set_team_group_name(team_group_name)
			player_bullet.orientation = get_scale()
			player_bullet.set_pos(get_pos())
			get_node("/root/Game").add_child(player_bullet)
			can_shoot = false
			shooting_timer.start()
	elif action == "action_select_left":
		_show_scrap_menu()
		selected_scrap_to_drop =  scrap_selection_menu.select_previous_scrap()
	elif action == "action_select_right":
		_show_scrap_menu()
		selected_scrap_to_drop = scrap_selection_menu.select_next_scrap()


func _handle_movement(delta):
	velocity += Constants.GRAVITY * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL, Constants.FRICTION)

	if !shocked:
		var movement = controller.movement_vector
		velocity.x = lerp(velocity.x, movement.x * Constants.PLAYER_MOVEMENT_SPEED, ACCELERATION)
	else:
		velocity.x = 0
	
	# Rotate the player
	if controller.movement_vector.x != 0:
		set_scale(Vector2((controller.movement_vector.x / abs(controller.movement_vector.x)), get_scale().y))

func _init_scrap_inventory():
	scrap_inventory = {
		"missile" : Constants.PLAYER_MISSILE_INITIAL_AMOUNT,
		"laser"   : Constants.PLAYER_LASER_INITIAL_AMOUNT,
		"shield"  : Constants.PLAYER_SHIELD_INITIAL_AMOUNT,
		"wings"   : Constants.PLAYER_WINGS_INITIAL_AMOUNT
	}

func _init_scrap_selection_menu():
	selected_scrap_to_drop = scrap_selection_menu.selected_scrap_to_drop
	_show_scrap_menu()

func add_scrap_to_inventory(scrap_name):
	scrap_inventory[scrap_name] += 1
	scrap_selection_menu.update_inventory(scrap_inventory)

func _init_station_active_flags():
	active_station = null

func _connect_to_signals():
	area.connect("area_enter", self, "_on_area_enter")
	area.connect("area_exit", self, "_on_area_exit")

func _on_area_enter(area):
	if area.is_in_group(team_group_name) && area.is_in_group("power_up_station"):
		_on_station_enter("power_up_station")

	if area.is_in_group(team_group_name) && area.is_in_group("economy_station"):
		_on_station_enter("economy_station")
	
	if !area.is_in_group(team_group_name) && area.is_in_group("player_bullet"):
		shocked = true
		shocked_timer.start()

func _on_area_exit(area):
	if area.is_in_group(team_group_name) && area.is_in_group("power_up_station"):
		_on_station_exit()

	if area.is_in_group(team_group_name) && area.is_in_group("economy_station"):
		_on_station_exit()

func _on_station_enter(station):
	active_station = station

func _on_station_exit():
	active_station = null

func _drop_scraps_to_power_up_station():
	if scrap_inventory[selected_scrap_to_drop] > 0:
		scrap_inventory[selected_scrap_to_drop] = scrap_inventory[selected_scrap_to_drop] - Constants.PLAYER_SCRAP_DEFAULT_DEPOSIT_AMOUNT
		station_manager.increment_power_up(Constants.PLAYER_SCRAP_DEFAULT_DEPOSIT_AMOUNT, selected_scrap_to_drop)
		scrap_selection_menu.update_inventory(scrap_inventory)

func _drop_scraps_to_economy_station():
	if scrap_inventory[selected_scrap_to_drop] > 0:
		scrap_inventory[selected_scrap_to_drop] = scrap_inventory[selected_scrap_to_drop] - Constants.PLAYER_SCRAP_DEFAULT_DEPOSIT_AMOUNT
		station_manager.increment_economy(Constants.PLAYER_SCRAP_DEFAULT_DEPOSIT_AMOUNT)
		scrap_selection_menu.update_inventory(scrap_inventory)

func _show_scrap_menu():
	scrap_selection_menu.show()

	if menu_timer != null:
		menu_timer.stop()

	menu_timer = TimerGenerator.create_timer(Constants.PLAYER_SCRAP_MENU_TIME_UNTIL_HIDE, "_hide_scrap_menu", self)
	menu_timer.start()

func _hide_scrap_menu():
	scrap_selection_menu.hide()

	if menu_timer != null: 
		menu_timer = null

func _print_debug_info():
	print(instance_name + " properties:")
	print("team_group_name: " + team_group_name)
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
