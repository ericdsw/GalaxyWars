extends Sprite

var current_level
var shield_amount
var team_group_name

func _ready():
	current_level = get_parent().current_level
	shield_amount = get_parent().get_node("StatProvider").get_shield_amount_for_level(current_level)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)
