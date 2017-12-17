extends Sprite

var current_level
var shield_amount

func _ready():
	current_level = get_parent().current_level
	shield_amount = get_parent().get_node("StatProvider").get_shield_amount_for_level(current_level)