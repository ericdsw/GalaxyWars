extends Area2D

export (String) var team_group_name

signal player_entered()
signal player_exited()

func _ready():
	_print_debug_info()
	
func _print_debug_info():
	print(get_name())
	print("team group name: " + team_group_name)
	print("--------------------")
