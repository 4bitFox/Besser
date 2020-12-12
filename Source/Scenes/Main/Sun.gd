extends WorldEnvironment


var sun_rotation = 35
var sun_speed = 0.1
var brightness_adjust = -0.3

var debug_sun_speed_modifier = 0.05


func _process(delta):
	sun(delta)
	sun_debug()
	
func sun(delta):
	if sun_rotation < 180:
		sun_rotation = sun_rotation + sun_speed * delta
		environment.background_sky.sun_latitude = sun_rotation
		$Sun.rotation_degrees.x = sun_rotation + 180
		$Moon.rotation_degrees.x = sun_rotation
	else:
		sun_rotation = -180
	
	
	##Brightness (exposure)##
	var sun_rotation_normal = abs(sun_rotation + 90)
	var sun_rotation_subtract = 0
	var sun_rotation_cycle = 0
	
	if sun_rotation_normal < 180:
		sun_rotation_cycle = sun_rotation_normal
	else:
		sun_rotation_subtract = 180 - sun_rotation_normal
		sun_rotation_cycle = 180 + sun_rotation_subtract
	

	var brightness = 0.01
	if sun_rotation_cycle != 0:
		brightness = sun_rotation_cycle / 180
	
	
	var brightness_adjusted = brightness + brightness_adjust
	
	if brightness_adjusted > 0.01:
		environment.tonemap_exposure = abs(brightness_adjusted)
		

func sun_debug():
	if Input.is_action_pressed("debug_sun_faster"):
		sun_speed += debug_sun_speed_modifier
	if Input.is_action_pressed("debug_sun_slower") and sun_speed >= 0:
		sun_speed -= debug_sun_speed_modifier
