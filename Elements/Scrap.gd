extends RigidBody2D

export (String, "missile", "laser", "shield", "wings") var scrap_type = "missile"

onready var area = get_node("Area2D")

func _ready():
	area.connect("area_enter", self, "_on_area_enter")

func _on_area_enter(body):
	if body.is_in_group("player"):
		body.get_parent().add_scrap_to_inventory(scrap_type)
		queue_free()