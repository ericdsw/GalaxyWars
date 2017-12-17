extends Node2D

onready var bullet_scene = load("res://Elements/Bullet.tscn")
onready var sprite = get_node("Sprite").get_texture()

# onready var missile_launcher_pos = get_node("MissileLauncherPos").get_pos()
# onready var laser_beam_pos = get_node("LaserBearmPos").get_pos()
# onready var wings_pos = get_node("WingsPos").get_pos()

var missile_launcher_pos = Vector2(63, 61)
var laser_beam_pos = Vector2(-60, -63)
var wings_pos = Vector2(-26, 21)


var bullet_starting_pos
var bullet_fire_timer

signal destroyed()

# TODO: fix this
var current_level = 3
var max_hp
var hp
var accuracy
var evasion
var base_attack
var orientation
var team_group_name

var wings_blessing_enabled = false

func _ready():
	set_stats()

	TimerGenerator.create_timer(1, "receive_damage", self, false, [20]).start()
	bullet_fire_timer = TimerGenerator.create_timer(Constants.BULLET_FIRE_RATE, "spawn_bullet", self, false)
	bullet_fire_timer.start()

func set_stats():
	var stat_provider = get_node("StatProvider")
	
	max_hp = stat_provider.get_max_hp_for_level(current_level)
	hp = max_hp
	accuracy = stat_provider.get_accuracy_for_level(current_level)
	evasion = stat_provider.get_evasion_for_level(current_level)

	if (wings_blessing_enabled):
		evasion += stat_provider.get_wing_evasion_for_level(current_level)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func receive_damage(damage):
	hp -= damage
	if (hp <= 0):
		emit_signal("destroyed")
		queue_free()

func spawn_bullet():
	
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_pos(get_pos() + Vector2(orientation * 75, 0))
	bullet_instance.orientation = orientation
	bullet_instance.set_team_group_name(team_group_name)

	get_node("/root/Game").add_child(bullet_instance)
	
	var variance_ref = Constants.BULLET_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	bullet_fire_timer.set_wait_time(Constants.BULLET_FIRE_RATE + variance)

func enable_wings_blessing():
	wings_blessing_enabled = true
