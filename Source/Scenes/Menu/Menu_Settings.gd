extends Node2D

onready var settings = get_node("/root/Settings")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#Load Settings and apply in menu
	get_settings()
	indicator()


func _process(_delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("scene_restart"):
		var reload_scene = get_tree().reload_current_scene()
		if reload_scene != 0:
			print("Error ", reload_scene, " while reloading the scene.")
		
#	if Input.is_action_just_pressed("game_pause"):
#		$UI/Indicators/Loading.visible = true
	if Input.is_action_just_released("game_pause"):
		var change_scene = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
		if change_scene != 0:
			print("Error ", change_scene, " while changing the scene.")
			



func get_settings():
	$"UI/Settings/Graphics/Render distance/Slider_Rdist".value = settings.read("Graphics","render_distance",8192)
	$"UI/Settings/Graphics/Trees distance/Slider_Tdist".value = settings.read("Graphics","trees_distance",400)
	$"UI/Settings/Graphics/Grass distance/Slider_Gdist".value = settings.read("Graphics","grass_distance",200)
	$"UI/Settings/Graphics/Grass density/Slider_Gdens".value = settings.read("Graphics","grass_density",1.5)
	$"UI/Settings/Controls/Mouse speed/Slider_Mspd".value = settings.read("Controls","mouse_speed",0.5)

func indicator():
	#Value indicator
	$"UI/Settings/Graphics/Render distance/Value".text = String($"UI/Settings/Graphics/Render distance/Slider_Rdist".value)
	$"UI/Settings/Graphics/Trees distance/Value".text = String($"UI/Settings/Graphics/Trees distance/Slider_Tdist".value)
	$"UI/Settings/Graphics/Grass distance/Value".text = String($"UI/Settings/Graphics/Grass distance/Slider_Gdist".value)
	$"UI/Settings/Graphics/Grass density/Value".text = String($"UI/Settings/Graphics/Grass density/Slider_Gdens".value)
	$"UI/Settings/Controls/Mouse speed/Value".text = String($"UI/Settings/Controls/Mouse speed/Slider_Mspd".value)


func _on_Slider_Rdist_value_changed(value):
	settings.save("Graphics","render_distance",value)
	indicator()

func _on_Slider_Tdist_value_changed(value):
	settings.save("Graphics","trees_distance",value)
	indicator()

func _on_Slider_Gdist_value_changed(value):
	settings.save("Graphics","grass_distance",value)
	indicator()

func _on_Slider_Gdens_value_changed(value):
	settings.save("Graphics","grass_density",value)
	indicator()


func _on_Slider_Mspd_value_changed(value):
	settings.save("Controls","mouse_speed",value)
	indicator()
