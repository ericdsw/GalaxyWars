extends Node2D

onready var missile_scene = load("res://Elements/PowerUps/Missile.tscn")

var missile_fire_timer
var orientation
var team_group_name
var base_attack
var accuracy

func _ready():
	missile_fire_timer = TimerGenerator.create_timer(Constants.MISSILE_FIRE_RATE, "spawn_missile", self, false)
	missile_fire_timer.start()

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func spawn_missile():
	var missile_instance = missile_scene.instance()
	missile_instance.set_pos(get_global_pos())
	missile_instance.orientation = orientation
	missile_instance.set_team_group_name(team_group_name)
	missile_instance.base_attack = base_attack
	missile_instance.accuracy = accuracy

	get_node("/root/Game").add_child(missile_instance)
	
	var variance_ref = Constants.MISSILE_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	missile_fire_timer.set_wait_time(Constants.MISSILE_FIRE_RATE + Constants.MISSILE_FIRE_RATE_VARIANCE)

