extends Node

onready var player_1 = get_node("Player1")
onready var player_2 = get_node("Player2")

onready var station_manager_1 = get_node("StationManager1")
onready var station_manager_2 = get_node("StationManager2")

func _ready():
	player_1.station_manager = station_manager_1
	player_2.station_manager = station_manager_2
