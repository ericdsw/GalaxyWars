extends Node

onready var battleship_scene = load("res://Elements/Battleship.tscn")

var economy;
var scrap_inventory;

func _ready():
    _init_economy()
    _init_scrap_inventory()

func _init_economy()
    economy = ECONOMY_INITIAL_AMOUNT

func _init_inventory()
    scrap_inventory = {
	"missile": SCRAP_TYPE_MISSILE_INITIAL_AMOUNT,
	"laser": SCRAP_TYPE_LASER_INITIAL_AMOUNT,
	"shield": SCRAP_TYPE_SHIELD_INITIAL_AMOUNT,
	"wings": SCRAP_TYPE_WINGS_INITIAL_AMOUNT
    }

func spawn_battleship():
	var battleship_instance = battleship_scene.instance()
	battleship_instance.set_pos(Vector2(300, 300))
	get_tree().get_root().get_node("Game").add_child(battleship_instance)
	
	battleship_instance.connect("destroyed", self, "_on_ship_destroyed")

func increment_economy(scrap_amount):
    economy += scrap_amount

func increment_power_up(scrap_amount, scrap_type):
    scrap_inventory[scrap_type] = scrap_inventory[scrap_type] - 1

func _on_ship_destroyed():
	TimerGenerator.create_timer(3, "spawn_battleship", self).start()
