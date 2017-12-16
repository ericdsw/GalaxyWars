extends Node

onready var battleship_scene = load("res://Elements/Battleship.tscn")

func spawn_battleship():
	var battleship_instance = battleship_scene.instance()
	battleship_instance.set_pos(Vector2(300, 300))
	get_tree().get_root().get_node("Game").add_child(battleship_instance)
	
	battleship_instance.connect("destroyed", self, "_on_ship_destroyed")

func _on_ship_destroyed():
	TimerGenerator.create_timer(3, "spawn_battleship", self).start()