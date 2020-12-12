extends CanvasLayer

onready var ArVr = get_node("/root/ArVr")

var active = false
	

func _ready():
	rotation_degrees = 180



func _process(_delta):
	visibility()


func visibility():
	if Input.is_action_just_pressed("game_pause"):
		if active == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			rotation_degrees = 0
			active = true
			get_tree().paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			rotation_degrees = 180
			active = false
			get_tree().paused = false


func _on_Continue_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rotation_degrees = 180
	active = false
	get_tree().paused = false


func _on_Main_Menu_pressed():
	get_tree().paused = false
	var change_scene = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
	if change_scene != 0:
		print("Error ", change_scene, " while changing the scene.")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_in_VR_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rotation_degrees = 180
	active = false
	get_tree().paused = false
	ArVr.initialize()
