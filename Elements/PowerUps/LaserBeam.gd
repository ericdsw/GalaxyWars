extends Node2D

onready var laser_scene = load("res://Elements/PowerUps/Laser.tscn")

var laser_fire_timer

func _ready():
	laser_fire_timer = TimerGenerator.create_timer(Constants.LASER_FIRE_RATE, "spawn_laser", self, false)
	laser_fire_timer.start()

func spawn_laser():
	var laser_instance = laser_scene.instance()
	laser_instance.set_pos(get_global_pos())
	get_node("/root/Game").add_child(laser_instance)
	
	var variance_ref = Constants.LASER_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	laser_fire_timer.set_wait_time(Constants.LASER_FIRE_RATE + Constants.LASER_FIRE_RATE_VARIANCE)

