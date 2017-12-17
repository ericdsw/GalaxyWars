extends KinematicBody2D

onready var area = get_node("Area2D")
onready var collision_particle_scene = load("res://Elements/General/CollisionParticle.tscn")

var direction = Vector2(1, 0)
var speed = Constants.BULLET_SPEED
var orientation
var team_group_name
var base_attack

var accuracy

func _ready():
	set_fixed_process(true)
	area.connect("area_enter", self, "_on_collision")
	area.add_to_group(team_group_name)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name

func get_damage_for_entity(entity):
	if entity == "battleship":
		return _get_attack() * Constants.MULTIPLIER_BULLET_TO_SHIP
	elif entity == "shield":
		return _get_attack() * Constants.MULTIPLIER_BULLET_TO_SHIELD
	elif entity == "tower":
		return _get_attack() * Constants.MULTIPLIER_BULLET_TO_TOWER

func get_accuracy():
	return accuracy

func _get_attack():
	return base_attack * Constants.BULLET_DAMAGE_MULTIPLIER

func _fixed_process(delta):
	move(orientation * direction * speed * delta)

func _on_collision(body):
	if !body.is_in_group(team_group_name) && !body.is_in_group("Projectile") :
		var collision_particle_instance = collision_particle_scene.instance()
		collision_particle_instance.set_pos(get_pos())
		get_node("/root/Game").add_child(collision_particle_instance)
		queue_free()
