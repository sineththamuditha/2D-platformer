extends Node2D


const camera_right_limit = 8000
const camera_bottom_limit = 720

@onready var player : Player = $Player
@onready var is_player_at_endpoint : bool = false

func _ready():
	var camera = player.get_node("player_camera")
	
	camera.set_camera_limits( 0, camera_right_limit, 0, camera_bottom_limit)

func _process(_delta):
	if Input.is_action_pressed("next") and is_player_at_endpoint :
		get_tree().change_scene_to_file("res://Level/3/scene.tscn")

func _on_endpoint_body_entered(_body):
	is_player_at_endpoint = true
	print("Player reached endpoint")
	


func _on_endpoint_body_exited(_body):
	is_player_at_endpoint = false
	print("Player exited endpoint")
 
