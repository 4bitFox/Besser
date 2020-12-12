extends Spatial

const SPEED = 4

onready var player = get_node("/root/Main/Player")

func _process(delta):
	var pos_to_player = player.translation - $Sprite.translation
	pos_to_player.y = 0
	$Sprite.translate(pos_to_player.normalized() * delta * SPEED)
