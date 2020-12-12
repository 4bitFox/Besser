extends Node2D



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("scene_restart"):
		var reload_scene = get_tree().reload_current_scene()
		if reload_scene != 0:
			print("Error ", reload_scene, " while reloading the scene.")
	
#	#Loading Indicator
#	if Input.is_action_just_pressed("game_pause"):
#		$UI/Indicators/Loading.visible = true
	if Input.is_action_just_released("game_pause"):
		var change_scene = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
		if change_scene != 0:
			print("Error ", change_scene, " while changing the scene.")
