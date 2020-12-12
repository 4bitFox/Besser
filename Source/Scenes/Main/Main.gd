extends Spatial

const WATER_HEIGHT = -1
const SAND_HEIGHT = 2
const GRASS_HEIGHT = 70
const STONE_HEIGHT = 1000


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	if $Player.translation.y < WATER_HEIGHT:
		$Player.sound(true, "Drown")
		$Player.sound(false, "Walk_Water")
	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		player_sound()
	else:
		player_sound_stop()
	

func player_sound():
	if $Player.translation.y >= WATER_HEIGHT and $Player.translation.y < SAND_HEIGHT:
		if Input.is_action_pressed("move_sprint"):
			$Player.sound(true, "Run_Water")
			#$Player.sound(false, "Walk_Water")
		else:
			#$Player.sound(false, "Run_Water")
			$Player.sound(true, "Walk_Water")
		$Player.sound(false, "Drown")
		$Player.sound(false, "Walk_Sand")
	elif $Player.translation.y >= SAND_HEIGHT and $Player.translation.y < GRASS_HEIGHT:
		if Input.is_action_pressed("move_sprint"):
			$Player.sound(true, "Run_Sand")
			$Player.sound(false, "Walk_Sand")
		else:
			$Player.sound(false, "Run_Sand")
			$Player.sound(true, "Walk_Sand")
		$Player.sound(false, "Walk_Water")
		$Player.sound(false, "Walk_Grass")
	elif $Player.translation.y >= GRASS_HEIGHT and $Player.translation.y < STONE_HEIGHT:
		if Input.is_action_pressed("move_sprint"):
			$Player.sound(true, "Run_Grass")
			#$Player.sound(false, "Walk_Grass")
		else:
			#$Player.sound(false, "Run_Grass")
			$Player.sound(true, "Walk_Grass")
		$Player.sound(false, "Walk_Sand")
		$Player.sound(false, "Walk_Stone")
	elif $Player.translation.y >= STONE_HEIGHT:
		if Input.is_action_pressed("move_sprint"):
			$Player.sound(true, "Run_Stone")
			$Player.sound(false, "Walk_Stone")
		else:
			$Player.sound(false, "Run_Stone")
			$Player.sound(true, "Walk_Stone")
		$Player.sound(false, "Walk_Grass")
		

func player_sound_stop():
	$Player.sound(false, "Drown")
	$Player.sound(false, "Walk_Water")
	$Player.sound(false, "Walk_Sand")
	$Player.sound(false, "Walk_Grass")
	$Player.sound(false, "Walk_Stone")
	$Player.sound(false, "Run_Water")
	$Player.sound(false, "Run_Sand")
	$Player.sound(false, "Run_Grass")
	$Player.sound(false, "Run_Stone")
