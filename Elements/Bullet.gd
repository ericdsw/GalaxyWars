extends KinematicBody2D

onready var area = get_node("Area2D")

var direction = Vector2(1, 0)
var speed = 100

func _ready():
	set_fixed_process(true)
	area.connect("area_enter", self, "_on_collision")

func _fixed_process(delta):
	move(direction * speed * delta)

func _on_collision(body):
	queue_free()