extends Node2D

func _ready():
	Global.potion_count = 0
	Global.player_health = 100

func _on_main_menu_btn_pressed():
	get_tree().change_scene_to_file("res://Main/main.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
