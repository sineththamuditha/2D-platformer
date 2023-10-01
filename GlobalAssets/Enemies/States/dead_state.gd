extends State

class_name DeathState

@export var death_sound : AudioStreamPlayer2D

func _ready():
	final_state = true

func on_enter():
	death_sound.play()
	playback.stop()
	playback.travel("death")
	get_parent().get_parent().queue_free()
