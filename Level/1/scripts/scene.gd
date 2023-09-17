extends Node2D

const camera_right_limit = 6900
const camera_bottom_limit = 720

@onready var player : Player = $Player

func _ready():
	var camera = player.get_node("player_camera")
	
	camera.set_camera_limits( 0, camera_right_limit, 0, camera_bottom_limit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Right = 6900
# bottom = 720
