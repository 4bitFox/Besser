extends KinematicBody

onready var settings = get_node("/root/Settings")
onready var ArVr = get_node("/root/ArVr")


var camera_yaw = 0
var camera_pitch = 0
var camera_pitch_max = 90
var camera_pitch_min = -80

var velocity = Vector3()
var direction = Vector3()
const GRAVITY = -9.8 * 4
const ACCELERATION = 4
const DEACCELERATION = 6
const SPEED = 5
const SPEED_MAX = 20
const SPEED_MAX_RUN = 35
var jump_height = 15

onready var mouse_sensitivity = settings.read("Controls","mouse_speed",0.5)

const SPEED_MAX_RUN_DEBUG=250
var jump_height_debug = 150

var water_height = -1

const FOV_NORMAL = 80
const FOV_ZOOMED = 20


func _ready():
	$Head/Camera.far = settings.read("Graphics","render_distance",8192)

func _process(delta):
	walk(delta)
	zoom()
	if ArVr.status() == false:
		underwater()
	else:
		rotation_degrees.y = $ARVROrigin/ARVRCamera.rotation_degrees.y
		$ARVROrigin.rotation_degrees.y = -rotation_degrees.y
	 
	if Input.is_action_just_pressed("ArVr_initialize"):
		ArVr.initialize()
		
	


func walk(delta):
	var aim = $Head.get_global_transform().basis
	direction = Vector3(0, 0, 0)
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	
	direction = direction.normalized()
	
	var velocity_nograv = velocity
	velocity_nograv.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint") and $HUD/Stamina.value > 0:
		speed = SPEED_MAX_RUN
	##DEBUG
	elif Input.is_action_pressed("debug_move_sprint"):
		speed = SPEED_MAX_RUN_DEBUG
	##
	else:
		speed = SPEED_MAX
		
	var target = direction * speed
	
	var acceleration
	if direction.dot(velocity_nograv) > 0:
		acceleration = ACCELERATION
	else:
		acceleration = DEACCELERATION
	
	velocity_nograv = velocity_nograv.linear_interpolate(target, acceleration * delta)
	velocity.x = velocity_nograv.x
	velocity.z = velocity_nograv.z
	
	
	if is_on_floor() and Input.is_action_pressed("move_jump"):
		velocity.y = jump_height
	##DEBUG
	elif is_on_floor() and Input.is_action_pressed("debug_move_jump"):
		velocity.y = jump_height_debug
	##
		
	#Make player stop when nothing pressed
	var is_moving = false

	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_just_pressed("move_jump"):
		is_moving = true
	else:
		is_moving = false

	if is_moving == true or is_on_floor() == false:
		velocity.y += GRAVITY * delta
		velocity = move_and_slide(velocity, Vector3(0, 1, 0))


func _input(event):
	if event is InputEventMouseMotion:
		camera_yaw += -event.relative.x * mouse_sensitivity
		camera_pitch += -event.relative.y * mouse_sensitivity
		
		if camera_yaw > 180:
			camera_yaw = -180
		if camera_yaw < -180:
			camera_yaw = 180
		
		if camera_pitch < camera_pitch_min:
			camera_pitch = camera_pitch_min
		if camera_pitch > camera_pitch_max:
			camera_pitch = camera_pitch_max
		
		$Head.rotation_degrees.y = camera_yaw
		$Head/Camera.rotation_degrees.x = camera_pitch

func underwater():
	var Translation = translation
	
	if Translation[1] <= water_height:
		$Head/Camera_underwater.rotation = $Head/Camera.rotation
		$Head/Camera_underwater.current = true
	else:
		$Head/Camera.current = true


func zoom():
	if Input.is_action_pressed("camera_zoom"):
		$Head/Camera.fov = FOV_ZOOMED
	else:
		$Head/Camera.fov = FOV_NORMAL

func sound(status, sound):
	if sound == "Walk_Grass" or sound == "Run_Grass":
		if $Head/Walk_Grass1.playing != status:
			$Head/Walk_Grass1.playing = status
	elif sound == "Walk_Sand":
		if $Head/Walk_Sand1.playing != status:
			$Head/Walk_Sand1.playing = status
	elif sound == "Walk_Stone":
		if $Head/Walk_Stone1.playing != status:
			$Head/Walk_Stone1.playing = status
	elif sound == "Walk_Water" or sound == "Run_Water":
		if $Head/Walk_Water1.playing != status:
			$Head/Walk_Water1.playing = status
	elif sound == "Run_Sand":
		if $Head/Run_Sand1.playing != status:
			$Head/Run_Sand1.playing = status
	elif sound == "Run_Stone":
		if $Head/Run_Stone1.playing != status:
			$Head/Run_Stone1.playing = status
	elif sound == "Drown":
		if $Head/Drown1.playing != status:
			$Head/Drown1.playing = status
		
