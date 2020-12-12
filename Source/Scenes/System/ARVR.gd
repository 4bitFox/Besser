extends Node

var arvr_status = false

func initialize():
	var arvr_interface = ARVRServer.find_interface("OpenVR")
	if arvr_interface and arvr_interface.initialize():
		print("Enabling ARVR...")
		get_viewport().arvr = true
		get_viewport().hdr = false
		
		OS.vsync_enabled = false
		Engine.target_fps = 90
		
		arvr_status = true
		
		return(0)
	else:
		return(1)

func status():
	return(arvr_status)
