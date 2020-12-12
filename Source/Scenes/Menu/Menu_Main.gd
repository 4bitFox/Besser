extends Node2D



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _process(_delta):
	if Input.is_action_just_pressed("game_pause"):
		get_tree().quit()
