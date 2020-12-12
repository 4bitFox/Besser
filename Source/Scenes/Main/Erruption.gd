extends Particles


func _process(_delta):
	if Input.is_action_pressed("debug_erruption"):
		emitting = true
	else:
		emitting = false
