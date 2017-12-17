extends Node2D

onready var missile_scene = load("res://Elements/PowerUps/Missile.tscn")

var missile_fire_timer
var orientation

func _ready():
	missile_fire_timer = TimerGenerator.create_timer(Constants.MISSILE_FIRE_RATE, "spawn_missile", self, false)
	missile_fire_timer.start()

func spawn_missile():
	var missile_instance = missile_scene.instance()
	missile_instance.set_pos(get_global_pos())
	missile_instance.orientation = orientation

	get_node("/root/Game").add_child(missile_instance)
	
	var variance_ref = Constants.MISSILE_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	missile_fire_timer.set_wait_time(Constants.MISSILE_FIRE_RATE + Constants.MISSILE_FIRE_RATE_VARIANCE)

