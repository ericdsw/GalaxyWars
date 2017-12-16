extends Node2D

onready var bullet_scene = load("res://Elements/Bullet.tscn")
var bullet_starting_pos

signal destroyed()

var hp = 100

func _ready():
	TimerGenerator.create_timer(1, "receive_damage", self, false, [20]).start()
	TimerGenerator.create_timer(0.5, "spawn_bullet", self, false).start()
	
	bullet_starting_pos = get_pos()

func receive_damage(damage):
	hp -= damage
	if (hp <= 0):
		emit_signal("destroyed")
		queue_free()

func spawn_bullet():
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_pos(bullet_starting_pos)
	get_node("/root/Game").add_child(bullet_instance)