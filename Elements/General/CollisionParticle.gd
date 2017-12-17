extends Particles2D

func _ready():
	TimerGenerator.create_timer(0.75, "_suicide", self).start()

func _suicide():
	queue_free()
