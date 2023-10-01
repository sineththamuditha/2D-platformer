extends State

class_name PlayerDeadState

@export var death_sound : AudioStreamPlayer2D

func _ready():
	final_state = true

func on_enter():
	death_sound.play()
