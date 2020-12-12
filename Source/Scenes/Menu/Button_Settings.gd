extends Button



func _on_Settings_pressed():
	var change_scene = get_tree().change_scene("res://Scenes/Menu/Settings.tscn")
	if change_scene != 0:
		print("Error ", change_scene, " while changing the scene.")
