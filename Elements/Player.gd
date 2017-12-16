extends KinematicBody2D

export var instance_name = "Player"

var scrap_inventory
var station_active_flags

func _ready():
	set_fixed_process(true)
	_init_scrap_inventory()
	_connect_to_signals()
	_print_debug_info()

func _fixed_process(delta):
	pass

func _init_scrap_inventory():
	scrap_inventory = {
		"missile": 0,
		"laser": 0,
		"shield": 0,
		"wings": 0
	}

func init_station_active_flags():
	station_active_flags = {
		"economy_station": false,
		"power_up_station": false,
	}

func _connect_to_signals():
	connect("player_entered", self, "_on_player_entered")
	connect("player_exited", self, "_on_player_exited")

func _on_player_entered(area):
	print("player entered area: " + area)
	station_active_flags[area]: true

func _on_player_exited(area):
	print("player entered area: " + area)
	station_active_flags[area]: true

func _print_debug_info():
	print(instance_name + " properties:")
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
