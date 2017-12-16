extends Node

func create_timer(duration, callback_name, target_object, one_shot = true, parameters = []):
	var timer = TimerWrapper.new(duration, callback_name, target_object, one_shot, parameters)
	return timer

class TimerWrapper extends Node:

	var timer
	var autocancel = true

	func _init(duration, callback_name, target_object, one_shot = true, parameters = []):
		timer = Timer.new()
		timer.set_one_shot(one_shot)
		timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
		timer.set_wait_time(duration)
		timer.connect("timeout", target_object, callback_name, parameters)
		timer.connect("timeout", self, "_on_timer_callback_finish")
		autocancel = one_shot
		add_child(timer)
		target_object.add_child(self)
	
	func set_autocancel(autocancel):
		self.autocancel = autocancel

	func start():
		timer.start()
	
	func set_wait_time(time):
		timer.set_wait_time(time)
	
	func stop():
		timer.stop()
	
	func _on_timer_callback_finish():
		if autocancel:
			queue_free()	
