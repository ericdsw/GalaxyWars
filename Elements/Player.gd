extends KinematicBody2D

export var instance_name = "Player"
export (String) var team_group_name

var station_manager
var scrap_inventory
var active_station

onready var area = get_node("Area2D")

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	_init_scrap_inventory()
	_init_station_active_flags()
	_connect_to_signals()
	_print_debug_info()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if active_station == "power_up_station":
			_drop_scraps_to_power_up_station()

		elif active_station == "economy_station":
			_drop_scraps_to_economy_station()

		# TODO: else attack
	
func _fixed_process(delta):
	_handle_movement(delta)

func _handle_movement(delta):
	var direction = Vector2(0,0)

	
	if Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, 0)

	if Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0)

	move(direction * 100 * delta);

func _init_scrap_inventory():
	scrap_inventory = {
		"missile": 0,
		"laser": 0,
		"shield": 0,
		"wings": 0
	}

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
	print("Scraps dropped to power up station")

func _drop_scraps_to_economy_station():
	print("Scraps dropped to economy station")

func _print_debug_info():
	print(instance_name + " properties:")
	print("team_group_name: " + team_group_name)
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
