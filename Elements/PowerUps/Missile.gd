extends KinematicBody2D

onready var area = get_node("Area2D")

var direction = Vector2(1, 0)
var speed = Constants.MISSILE_SPEED
var orientation
var team_group_name
var base_attack

func _ready():
	set_fixed_process(true)

	set_scale(Vector2(orientation, 1))

	area.connect("area_enter", self, "_on_collision")
	area.add_to_group(team_group_name)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name

func get_damage_for_entity(entity):
	if entity == "battleship":
		return _get_attack() * Constants.MULTIPLIER_MISSILE_TO_SHIP
	elif entity == "shield":
		return _get_attack() * Constants.MULTIPLIER_MISSILE_TO_SHIELD
	elif entity == "tower":
		return _get_attack() * Constants.MULTIPLIER_MISSILE_TO_TOWER

func _get_attack():
	return base_attack * Constants.MISSILE_DAMAGE_MULTIPLIER

func _fixed_process(delta):
	move(orientation * direction * speed * delta)

func _on_collision(body):
	if !body.is_in_group(team_group_name) && !body.is_in_group("Projectile") :
		queue_free()
