extends Node2D

const camera_right_limit = 4570
const camera_bottom_limit = 650


@onready var player : Player = $Player

func _ready():
	var camera = player.get_node("player_camera")
	
	camera.set_camera_limits( 0, camera_right_limit, 0, camera_bottom_limit)
	
	camera.change_zoom(Vector2(1.7,1.7))
