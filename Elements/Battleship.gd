extends Node2D

const scrap_types = ["MissileScrap.tscn", "LaserScrap.tscn", "ShieldScrap.tscn", "WingsScrap.tscn"]

onready var bullet_scene = load("res://Elements/Bullet.tscn")
onready var sprite = get_node("Sprite").get_texture()
onready var stat_provider = get_node("StatProvider")
	
# Fixed positions for power ups
var missile_launcher_pos = Vector2(63, 61)
var laser_beam_pos = Vector2(-30, -63)
var wings_pos = Vector2(-26, 21)

var bullet_fire_timer

signal destroyed()

var current_level = BATTLESHIP_INITIAL_LEVEL
var max_hp
var hp
var accuracy
var evasion
var base_attack
var orientation
var team_group_name

var wings_blessing_enabled = false

func _ready():
	_init_stats()

	TimerGenerator.create_timer(0.2, "receive_damage", self, false, [50]).start()
	bullet_fire_timer = TimerGenerator.create_timer(Constants.BULLET_FIRE_RATE, "spawn_bullet", self, false)
	bullet_fire_timer.start()

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func receive_damage(damage):
	hp -= damage
	if (hp <= 0):
		_spawn_scraps()
		emit_signal("destroyed")
		queue_free()

func spawn_bullet():
	
	var bullet_instance = bullet_scene.instance()
	bullet_instance.set_pos(get_pos() + Vector2(orientation * 75, 0))
	bullet_instance.orientation = orientation
	bullet_instance.set_team_group_name(team_group_name)
	bullet_instance.base_attack = base_attack

	get_node("/root/Game").add_child(bullet_instance)
	
	var variance_ref = Constants.BULLET_FIRE_RATE_VARIANCE
	var variance = rand_range(-variance_ref, variance_ref)
	bullet_fire_timer.set_wait_time(Constants.BULLET_FIRE_RATE + variance)

func enable_wings_blessing():
	wings_blessing_enabled = true

func _spawn_scraps():
	var contained_bonus = []
	for node in get_children():
		if ["MissileLauncher", "LaserBeam", "Wings", "Shield"].has(node.get_name()):
			contained_bonus.append(node.get_name())
	_drop_default_scraps()
	_drop_bonus_scraps(contained_bonus)

func _drop_default_scraps():
	for i in range(0, 2):
		var random_offset = rand_range(0, 4)
		var scrap = load("res://Elements/" + scrap_types[random_offset]).instance()
		_add_scrap_to_world(scrap)

func _drop_bonus_scraps(contained_bonus):
	if contained_bonus.has("MissileLauncher"):
		for i in range(0, Constants.BONUS_SCRAP_DROP_QUANTITY):
			var scrap = load("res://Elements/MissileScrap.tscn").instance()
			_add_scrap_to_world(scrap)
	if contained_bonus.has("LaserBeam"):
		for i in range(0, Constants.BONUS_SCRAP_DROP_QUANTITY):
			var scrap = load("res://Elements/LaserScrap.tscn").instance()
			_add_scrap_to_world(scrap)
	if contained_bonus.has("Wings"):
		for i in range(0, Constants.BONUS_SCRAP_DROP_QUANTITY):
			var scrap = load("res://Elements/WingsScrap.tscn").instance()
			_add_scrap_to_world(scrap)
	if contained_bonus.has("Shield"):
		for i in range(0, Constants.BONUS_SCRAP_DROP_QUANTITY):
			var scrap = load("res://Elements/ShieldScrap.tscn").instance()
			_add_scrap_to_world(scrap)
	

func _generate_random_force():
	return Vector2(get_scale().x * (rand_range(10, 400)), rand_range(-30, 30))

func _add_scrap_to_world(scrap):
	scrap.set_pos(get_pos())
	get_node("/root/Game").add_child(scrap)
	scrap.apply_impulse(Vector2(15, 15), _generate_random_force())

func _init_stats():
	max_hp = stat_provider.get_max_hp_for_level(current_level)
	accuracy = stat_provider.get_accuracy_for_level(current_level)
	evasion = stat_provider.get_evasion_for_level(current_level)

	_fill_hp()

	if (wings_blessing_enabled):
		evasion += stat_provider.get_wing_evasion_for_level(current_level)

func _fill_hp():
	hp = max_hp
