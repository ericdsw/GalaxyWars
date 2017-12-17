extends Node

export (int, "Player 1", "Player 2") var device_id = 0

var movement_vector = Vector2(0,0)

signal button_pressed(action)

func _ready():
	set_process_input(true)

func _input(event):
	_handle_movement(event)
	_handle_buttons(event)

func _handle_buttons(input_event):
	if input_event.device == device_id:
		if input_event.is_action_pressed("action_primary"):
			emit_signal("button_pressed", "action_primary")
		if input_event.is_action_pressed("action_shoot"):
			emit_signal("button_pressed", "action_shoot")
		if input_event.is_action_pressed("action_select_left"):
			emit_signal("button_pressed", "action_select_left")
		if input_event.is_action_pressed("action_select_right"):
			emit_signal("button_pressed", "action_select_right")

func _handle_movement(input_event):
	if input_event.device == device_id:

		if input_event.is_action_pressed("action_left")     : movement_vector += Vector2(-1, 0)
		elif input_event.is_action_released("action_left")  : movement_vector += Vector2(1, 0)
		if input_event.is_action_pressed("action_right")    : movement_vector += Vector2(1, 0)
		elif input_event.is_action_released("action_right") : movement_vector += Vector2(-1, 0)
