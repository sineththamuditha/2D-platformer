extends Node2D

@onready var main_sound : AudioStreamPlayer2D = $main_sound

func _ready():
	if main_sound.playing == false :
		main_sound.play()

func _on_quit_button_down():
	get_tree().quit();

func _on_play_button_down():
	get_tree().change_scene_to_file("res://Scene_between/controls.tscn");
	#get_tree().change_scene_to_file("res://test/test.tscn");
