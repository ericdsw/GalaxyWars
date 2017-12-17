extends Node2D

var who_won = "no one"

func _ready():
	get_node("Label 2").set_text(who_won + " wins!")
