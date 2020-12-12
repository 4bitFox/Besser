extends CanvasLayer

onready var ArVr = get_node("/root/ArVr")

var active = true

var stamina_decrease = 5
var stamina_recover = 2

func _ready():
	rotation_degrees = 0

func _process(delta):
	visibility()
	stamina(delta)


func visibility():
	if ArVr.status() == false:
		if Input.is_action_just_pressed("hud"):
			if active == false:
				rotation_degrees = 0
				active = true
			else:
				rotation_degrees = 180
				active = false
	else:
		rotation_degrees = 180
		active = false
			

func stamina(delta):
	if Input.is_action_pressed("move_sprint"):
		$Stamina.value -= stamina_decrease * delta
	else:
		$Stamina.value += stamina_recover * delta
	
	if Input.is_action_just_pressed("move_jump"):
		$Stamina.value -= stamina_decrease / 2
		
