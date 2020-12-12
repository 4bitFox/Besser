extends Node


func _process(_delta):
	#Fullscreen
	if Input.is_action_just_pressed("game_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	#Quit
	if Input.is_action_just_pressed("game_quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	#Scene restart
	if Input.is_action_just_pressed("scene_restart"):
		var reload_scene = get_tree().reload_current_scene()
		if reload_scene != 0:
			print("Error ", reload_scene, " while reloading the scene.")
