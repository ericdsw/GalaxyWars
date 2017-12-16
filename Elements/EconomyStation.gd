extends Area2D

var team_group_name

signal player_entered()
signal player_exited()

func _ready():
	_connect_to_signals()
	_print_debug_info()
	
func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name

func _connect_to_signals():
	connect("body_enter", self, "_on_body_enter")
	connect("body_exit", self, "_on_body_exit")

func _on_body_enter(body):
	if body.is_in_group(team_group_name) && body.is_in_group("player"):
		emit_signal("player_entered", ["economy_station"])

func _on_body_exit(body):
	if body.is_in_group(team_group_name) && body.is_in_group("player"):
		emit_signal("player_exited", ["economy_station"])

func _print_debug_info():
	print("Economy Station")
	print("team group name: " + team_group_name)
	print("--------------------")
