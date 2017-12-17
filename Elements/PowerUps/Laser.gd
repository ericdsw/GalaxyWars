extends KinematicBody2D

onready var area = get_node("Area2D")
onready var particles = get_node("Particles2D")

var direction = Vector2(1, 0)
var speed = Constants.LASER_SPEED
var orientation
var team_group_name

func _ready():
	set_fixed_process(true)

	var angle_orientation
	if orientation == -1:
		angle_orientation = 90
	else:
		angle_orientation = 270 

	particles.set_param(particles.PARAM_DIRECTION, angle_orientation)

	area.connect("area_enter", self, "_on_collision")

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func _fixed_process(delta):
	move(orientation * direction * speed * delta)

func _on_collision(body):
	if !body.is_in_group(team_group_name) && !body.is_in_group("Projectile") :
		queue_free()

	# if body.is_in_group("Damageable"):
	# 	speed /= 1.75
	# 	particles.set_emitting(false)

	# 	TimerGenerator.create_timer(particles.get_lifetime(), "destroy_laser", self).start()

# func destroy_laser():
# 	if !body.is_in_group("Projectile"):
# 		queue_free()
