extends KinematicBody2D

export var instance_name = "Player"
export (String) var team_group_name

var station_manager
var scrap_inventory
var station_active_flags

onready var area = get_node("Area2D")

func _ready():
	set_fixed_process(true)
	_init_scrap_inventory()
	_init_station_active_flags()
	_connect_to_signals()
	_print_debug_info()
	
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
	station_active_flags = {
		"economy_station": false,
		"power_up_station": false,
	}

func _connect_to_signals():
	area.connect("area_enter", self, "_on_area_enter")
	area.connect("area_exit", self, "_on_area_exit")

func _on_area_enter(area):
	if area.is_in_group(team_group_name) && area.is_in_group("power_up_station"):
		_on_power_up_station_enter()

	if area.is_in_group(team_group_name) && area.is_in_group("economy_station"):
		_on_economy_station_enter()

func _on_area_exit(area):
	if area.is_in_group(team_group_name) && area.is_in_group("power_up_station"):
		_on_power_up_station_exit()

	if area.is_in_group(team_group_name) && area.is_in_group("economy_station"):
		_on_economy_station_exit()

func _on_power_up_station_enter():
	print("power up enter")
	station_active_flags["power_up_station"] = true

func _on_economy_station_enter():
	station_active_flags["economy_station"] = true

func _on_power_up_station_exit():
	print("power up exit")
	station_active_flags["power_up_station"] = false

func _on_economy_station_exit():
	station_active_flags["economy_station"] = false

func _print_debug_info():
	print(instance_name + " properties:")
	print("team_group_name: " + team_group_name)
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
