extends Node2D

export var instance_name = "Station Manager"
export (String) var team_group_name
export var orientation = 1

onready var battleship_scene = load("res://Elements/Battleship.tscn")

var economy
var scrap_inventory

func _ready():
	_init_economy()
	_init_scrap_inventory()

	_print_debug_info()
	TimerGenerator.create_timer(1, "spawn_battleship", self, true).start()

func _on_ship_destroyed():
	TimerGenerator.create_timer(3, "spawn_battleship", self).start()

func spawn_battleship():
	var battleship_instance = battleship_scene.instance()

	battleship_instance.orientation = orientation
	battleship_instance.set_pos(get_pos() + Vector2(orientation * 75, -100))
	battleship_instance.set_scale(Vector2(orientation, 1))

	# TODO: add power up based on inventory

	get_tree().get_root().get_node("Game").add_child(battleship_instance)
	
	battleship_instance.connect("destroyed", self, "_on_ship_destroyed")


func increment_economy(scrap_amount):
	economy += scrap_amount

func increment_power_up(scrap_amount, scrap_type):
	scrap_inventory[scrap_type] = scrap_inventory[scrap_type] + 1

func _init_economy():
	economy = Constants.STATION_MANAGER_ECONOMY_INITIAL_AMOUNT

func _init_scrap_inventory():
	scrap_inventory = {
		"missile": Constants.STATION_MANAGER_MISSILE_INITIAL_AMOUNT,
		"laser": Constants.STATION_MANAGER_LASER_INITIAL_AMOUNT,
		"shield": Constants.STATION_MANAGER_SHIELD_INITIAL_AMOUNT,
		"wings": Constants.STATION_MANAGER_WINGS_INITIAL_AMOUNT
	}

func _print_debug_info():
	print("Station Manager")
	print("instance name: " + instance_name)
	print("team group name: " + team_group_name)
	print("missile: " + str(scrap_inventory["missile"]))
	print("laser: " + str(scrap_inventory["laser"]))
	print("shield: " + str(scrap_inventory["shield"]))
	print("wings: " + str(scrap_inventory["wings"]))
	print("------------------------------------")
