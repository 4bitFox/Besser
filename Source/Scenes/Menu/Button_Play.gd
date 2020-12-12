extends Button



func _on_Play_pressed():
	var change_scene = get_tree().change_scene("res://Scenes/Main/Main.tscn")
	if change_scene != 0:
		print("Error ", change_scene, " while changing the scene.")
