extends Spatial

onready var settings = get_node("/root/Settings")


func _ready():
	details()
	

func details():
	#Distance
	$HTerrain/Grass.view_distance = settings.read("Graphics","grass_distance",200)
	$HTerrain/Trees1.view_distance = settings.read("Graphics","trees_distance",400)
	$HTerrain/Trees2.view_distance = settings.read("Graphics","trees_distance",400)
	#Density
	$HTerrain/Grass.density = settings.read("Graphics","grass_density",1.5)
