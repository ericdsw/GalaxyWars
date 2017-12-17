extends Node2D

onready var bullet_scene = load("res://Elements/Bullet.tscn")
onready var sprite = get_node("Sprite").get_texture()

var bullet_starting_pos
var bullet_fire_timer

signal destroyed()

var current_level = 3
var max_hp
var hp
var accuracy
var evasion
var base_attack

func _ready():
	set_stats()
	
	############# temporally adding wings 
	
	var wings_instance = load("res://Elements/PowerUps/Wings.tscn").instance()
	add_child(wings_instance)
	
	##############
	print(evasion)
	TimerGenerator.create_timer(1, "receive_damage", self, false, [20]).start()
	bullet_fire_timer = TimerGenerator.create_timer(Constants.BULLET_FIRE_RATE, "spawn_bullet", self, false)
	bullet_fire_timer.start()
	
	bullet_starting_pos = get_pos() + Vector2((sprite.get_width() / 2), 0)

func set_stats():
	var stat_provider = get_node("StatProvider")
	
	max_hp = stat_provider.get_max_hp_for_level(current_level)
	hp = max_hp
	accuracy = stat_provider.get_accuracy_for_level(current_level)
	evasion = stat_provider.get_evasion_for_level(current_level)

func receive_damage(damage):
	hp -= damage
	if (hp <= 0):
		emit_signal("destroyed")
		queue_free()

func spawn_bullet():
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_pos(bullet_starting_pos)
	get_node("/root/Game").add_child(bullet_instance)
	
	var variance_ref = Constants.BULLET_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	bullet_fire_timer.set_wait_time(Constants.BULLET_FIRE_RATE + variance)