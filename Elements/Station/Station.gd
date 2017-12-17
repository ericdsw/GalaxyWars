extends Area2D

export (String) var team_group_name

signal player_entered()
signal player_exited()

func _ready():
	_connect_to_signals()
	_print_debug_info()

func _connect_to_signals():
	connect("area_enter", self, "_on_area_enter")
	connect("area_exit", self, "_on_area_exit")

func _on_area_enter(area):
	if area.is_in_group(team_group_name) && area.is_in_group("player"):
		_on_player_enter()

func _on_area_exit(area):
	if area.is_in_group(team_group_name) && area.is_in_group("player"):
		_on_player_exit()

func _on_player_enter():
	# TODO: light animation
	pass

func _on_player_exit():
	# TODO: light animation
	pass
	
func _print_debug_info():
	print(get_name())
	print("team group name: " + team_group_name)
	print("--------------------")
