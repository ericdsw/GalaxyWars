extends KinematicBody2D

onready var area = get_node("Area2D")

var direction = Vector2(1, 0)
var speed = Constants.PLAYER_BULLET_SPEED
var orientation
var team_group_name

func _ready():
	set_fixed_process(true)
	area.connect("area_enter", self, "_on_collision")
	area.add_to_group(team_group_name)

func set_team_group_name(team_group_name):
	self.team_group_name = team_group_name
	add_to_group(team_group_name)

func _fixed_process(delta):
	move(orientation * direction * speed * delta)

func _on_collision(body):
	# Only remove if the bullet hits another player
	if !body.is_in_group(team_group_name) && body.is_in_group("player") :
		queue_free()
