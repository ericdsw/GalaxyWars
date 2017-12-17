extends Label

var up_speed = 100

func _ready():
	TimerGenerator.create_timer(1, "_destroy_self", self).start()
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(get_pos() - Vector2(0, up_speed * delta))

func _destroy_self():
	queue_free()