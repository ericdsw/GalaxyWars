extends Sprite

var current_level

func _ready():
	current_level = get_parent().current_level
	get_parent().evasion += get_parent().get_node("StatProvider").get_wing_evasion_for_level(current_level)