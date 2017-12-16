extends Node

onready var station_manager = get_node("StationManager")

func _ready():
	station_manager.spawn_battleship()