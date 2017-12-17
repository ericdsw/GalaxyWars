extends Area2D

onready var scrap_indicator = {
	"missile": {
		"amount": 0,
		"label": get_node("MissileLabel")
	},
	"laser":{
		"amount": 0,
		"label": get_node("LaserLabel")
	},
	"shield":{
		"amount": 0,
		"label": get_node("ShieldLabel")
	},
	"wings":{
		"amount": 0,
		"label": get_node("WingsLabel")
	}
}

func _ready():
	pass

func update_inventory(scrap_inventory):
	for scrap in scrap_inventory.keys():
		scrap_indicator[scrap].amount = scrap_inventory[scrap]

	_update_labels()

func _update_labels():
	for scrap in ["missile", "laser", "shield", "wings"]:
		scrap_indicator[scrap].label.set_text(str(scrap_indicator[scrap].amount))
