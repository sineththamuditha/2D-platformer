extends Node2D

const camera_right_limit = 4570
const camera_bottom_limit = 650


@onready var player : Player = $Player
@onready var lich : Lich = $enemies/Lich
@onready var text_handler = $LocalTextHandler

var victory_flag : bool = false
var final_phase : bool = false
var initial_dialogue : bool = false

func _ready():
	var camera = player.get_node("player_camera")
	
	camera.set_camera_limits( 0, camera_right_limit, 0, camera_bottom_limit)
	
	camera.change_zoom(Vector2(1.7,1.7))
	
	show_dialogue()

func _physics_process(_delta):
	if !is_instance_valid(player):
		game_over()

	if !is_instance_valid(lich):
		victory()
		
	if Input.is_action_just_pressed("next"):
		if !initial_dialogue :
			initial_dialogue = true
			close_dialogue()
			show_level_info()
		elif victory_flag :
			get_tree().change_scene_to_file("res://Scene_between/victory_scene.tscn")
		else :
			close_level_info()
			close_dialogue()

func game_over() -> void :
	get_tree().change_scene_to_file("res://Scene_between/game_over_scene.tscn")
	
func victory() -> void :
	if victory_flag:
		return
	victory_flag = true
	show_dialogue()

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

func _on_checkpoint_area_3_body_entered(body):
	if !final_phase:
		show_dialogue()
		final_phase = true
