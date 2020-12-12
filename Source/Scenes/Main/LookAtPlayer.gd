extends Sprite3D


func _process(_delta):
	var target = get_viewport().get_camera().global_transform.origin
	target[1] = translation.y
	look_at(target, Vector3(0, 1, 0))
