extends Button



func _on_Credits_pressed():
	var change_scene = get_tree().change_scene("res://Scenes/Menu/Credits.tscn")
	if change_scene != 0:
		print("Error ", change_scene, " while changing the scene.")
	
