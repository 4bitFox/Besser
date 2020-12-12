extends CanvasLayer

var active = false

func _ready():
	rotation_degrees = 180

func _process(_delta):
	visibility()
	
	if active == true:
		coordinates()
		camera()
		performance()


func visibility():
	if Input.is_action_just_pressed("debug_menu"):
		if active == false:
			rotation_degrees = 0
			active = true
		else:
			rotation_degrees = 180
			active = false


func coordinates():
	var Translation = get_node("/root/Main/Player").translation
	
	var X = Translation[0]
	var Y = Translation[1]
	var Z = Translation[2]
	
	$Coordinates/X/Value.text = String(X)
	$Coordinates/Y/Value.text = String(Y)
	$Coordinates/Z/Value.text = String(Z)


func camera():
	var yaw = get_node("/root/Main/Player").get_node("Head").rotation_degrees[1]
	var pitch = get_node("/root/Main/Player").get_node("Head/Camera").rotation_degrees[0]
	
	var facing = "East"
	
	#Facing
	if yaw > -135 and yaw <= -45:
		facing = "South"
	elif yaw > -45 and yaw <= 45:
		facing = "East"
	elif yaw > 45 and yaw <= 135:
		facing = "North"
	else:
		facing = "West"
	
	$Camera/Facing/Value.text = String(facing)
	$Camera/Yaw/Value.text = String(yaw)
	$Camera/Pitch/Value.text = String(pitch)


func performance():
	var FPS = Performance.get_monitor(Performance.TIME_FPS)
	var FrameTime = Performance.get_monitor(Performance.TIME_PROCESS)
	var ObjectsInFrame = Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME)
	var VerticiesInFrame = Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME)
	
	$Performance/FPS/Value.text = String(FPS)
	$Performance/Frametime/Value.text = String(FrameTime * 1000) + ' ms'
	$Performance/Objects/Value.text = String(ObjectsInFrame)
	$Performance/Verticies/Value.text = String(VerticiesInFrame)

