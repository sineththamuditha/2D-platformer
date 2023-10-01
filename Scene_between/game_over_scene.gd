extends Node2D

@onready var timer : Timer = $game_over_scene_timer

func _ready():
	Global.potion_count = 0
	Global.player_health = 100
	
	timer.start()

func _on_game_over_scene_timer_timeout():
	get_tree().change_scene_to_file("res://Main/main.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_try_again_btn_pressed():
	get_tree().change_scene_to_file("res://Level/1/scene.tscn")
