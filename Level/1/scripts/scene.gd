extends Node2D

const camera_right_limit = 6900
const camera_bottom_limit = 720

@onready var player : Player = $Player
@onready var is_player_at_endpoint : bool = false
@onready var text_handler : LocalTextHandler = $LocalTextHandler
@onready var enemies : Node = $enemies

var dialogues_finished : bool
var initial_dialogue : bool = false

func _ready():
	dialogues_finished = false
	var camera = player.get_node("player_camera")
	show_dialogue()
	camera.set_camera_limits( 0, camera_right_limit, 0, camera_bottom_limit)

func _process(_delta):
	if !is_instance_valid(player):
		game_over()
		
	if Input.is_action_just_pressed("next") : 
		if !initial_dialogue :
			initial_dialogue = true
			close_dialogue()
			show_level_info()
		elif is_player_at_endpoint and dialogues_finished :
			Global.current_level = 2
			get_tree().change_scene_to_file("res://Level/2/scene.tscn")
		else :
			close_dialogue()
			close_level_info()

func _on_endpoint_body_entered(_body):
	is_player_at_endpoint = true
	print("Player reached endpoint")


func _on_endpoint_body_exited(_body):
	is_player_at_endpoint = false
	print("Player exited endpoint")

func show_dialogue() -> void :
	player.conversing = true
	text_handler.show_dialogue()
	
func close_dialogue() -> void :
	player.conversing = false
	text_handler.close_dialogue()
	
func show_level_info() -> void :
	player.conversing = true
	text_handler.show_level_info()

func close_level_info() -> void :
	player.conversing = false
	text_handler.close_level_info()
	
func is_all_enemies_dead() -> bool :
	return enemies.get_child_count() == 0


func _on_trigger_areas_body_entered(_body):
	if is_all_enemies_dead() :
		dialogues_finished = true
		show_dialogue()

func game_over():
	get_tree().change_scene_to_file("res://Scene_between/game_over_scene.tscn")

