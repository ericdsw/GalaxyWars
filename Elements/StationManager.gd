extends Node2D

export var instance_name = "Station Manager"
export var team_group_name = "player"

onready var battleship_scene = load("res://Elements/Battleship.tscn")

var economy
var scrap_inventory

func _ready():
	_init_economy()
	_init_scrap_inventory()
	_print_debug_info()

func _enter_tree():
	_set_group_to_children_recursively()

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

# Sets the `group` property to all it's first level children. Children
# cannot be accessed through the scene editor from game, so there's no
# know way of updating that.
func _set_group_to_children_recursively():
	for child in get_children():
		if child.has_method("set_team_group_name"):
			child.set_team_group_name(self.team_group_name)

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
