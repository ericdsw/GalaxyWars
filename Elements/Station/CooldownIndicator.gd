extends Node2D

onready var cooldown_time = Constants.STATION_SHIP_COOLDOWN
var reset_time            = 0.5

onready var indicator      = get_node("Indicator")
onready var cooldown_tween = get_node("CooldownTween")
onready var reset_tween    = get_node("ResetTween")

const ROTATION_SPEED   = 10
const INITIAL_ROTATION = 180
const MAX_ROTATION     = 0

var current_state = "idle"

signal cooldown_finished()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (current_state == "idle"):
		indicator.set_rot(deg2rad(MAX_ROTATION))
	elif (current_state == "running"):
		var rotation = deg2rad((MAX_ROTATION - INITIAL_ROTATION) * (delta / cooldown_time))
		indicator.rotate(rotation)
		if (indicator.get_rot() < 0):
			current_state = "idle"
			emit_signal("cooldown_finished")
	elif (current_state == "resetting"):
		var rotation = deg2rad((INITIAL_ROTATION - MAX_ROTATION) * (delta / reset_time))
		indicator.rotate(rotation)
		if (rad2deg(indicator.get_rot()) > 180):
			current_state = "running"

func start_cooldown():
	current_state = "resetting"
