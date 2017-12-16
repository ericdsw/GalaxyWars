extends KinematicBody2D

onready var area = get_node("Area2D")
onready var particles = get_node("Particles2D")

var direction = Vector2(1, 0)
var speed = Constants.LASER_SPEED

func _ready():
	set_fixed_process(true)
	area.connect("area_enter", self, "_on_collision")

func _fixed_process(delta):
	move(direction * speed * delta)

func _on_collision(body):
	if body.is_in_group("Damageable"):
		speed /= 1.75
		particles.set_emitting(false)
		#particles.set_param(particles.PARAM_DAMPING, 75)
		TimerGenerator.create_timer(particles.get_lifetime(), "destroy_laser", self).start()

func destroy_laser():
	queue_free()