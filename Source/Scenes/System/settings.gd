extends Node


var configFile = "user://settings.conf"
var config = ConfigFile.new()
var config_version = 1

var config_error = config.load(configFile)



func _ready():
	if config_error != 0:
		new()
	else:
		#Overwrite config with missmatching version
		if config.get_value("Config","version",-1) != config_version:
			print("Detected config with other version!")
		
	
func new():
	print("Writing new config file.")

	# Add values to config
	config.set_value("Graphics","render_distance",8192)
	config.set_value("Graphics","trees_distance",400)
	config.set_value("Graphics","grass_distance",200)
	config.set_value("Graphics","grass_density",1.5)
	
	config.set_value("Controls","mouse_speed",0.5)
	
#	config.set_value("Keys","quit",16777217)
#	config.set_value("Keys","move_forward",87)
#	config.set_value("Keys","move_backward",83)
#	config.set_value("Keys","move_left",65)
#	config.set_value("Keys","move_right",68)
#	config.set_value("Keys","move_run",16777237)
#	config.set_value("Keys","camera_zoom",67)
#	config.set_value("Keys","debug_menu",16777246)
	
	config.set_value("Config","version",config_version)
 
	# Save file 
	config.save(configFile)

func read(section,key,value):
	var value_read = config.get_value(section,key,value)
	print("Loaded [", section, "]: ", key, " = ", value_read)
	return(value_read)
	
func save(section,key,value):
	config.set_value(section,key,value)
	config.save(configFile)
	print("Saved [", section, "]: ", key, " = ", value)
