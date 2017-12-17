extends Node2D

export var instance_name = "Station Manager"
export (String) var team_group_name

onready var battleship_scene = load("res://Elements/Battleship.tscn")

var economy
var scrap_inventory

func _ready():
	_init_economy()
	_init_scrap_inventory()
	_print_debug_info()

func _on_ship_destroyed():
	TimerGenerator.create_timer(3, "spawn_battleship", self).start()

func spawn_battleship():
	var battleship_instance = battleship_scene.instance()
	battleship_instance.set_pos(Vector2(300, 300))
	# TODO: add power up based on inventory

	get_tree().get_root().get_node("Game").add_child(battleship_instance)
	
	battleship_instance.connect("destroyed", self, "_on_ship_destroyed")


func increment_economy(scrap_amount):
	economy += scrap_amount

func increment_power_up(scrap_amount, scrap_type):
	scrap_inventory[scrap_type] = scrap_inventory[scrap_type] - 1

func _init_economy():
	economy = Constants.ECONOMY_INITIAL_AMOUNT

func _init_scrap_inventory():
	scrap_inventory = {
	"missile": Constants.SCRAP_TYPE_MISSILE_INITIAL_AMOUNT,
	"laser": Constants.SCRAP_TYPE_LASER_INITIAL_AMOUNT,
	"shield": Constants.SCRAP_TYPE_SHIELD_INITIAL_AMOUNT,
	"wings": Constants.SCRAP_TYPE_WINGS_INITIAL_AMOUNT
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
