extends Area2D

class_name  Checkpoint

@export var checkpoint_priority : int

signal player_entered(body : Player, checkponit_priority : int)

func _on_body_entered(body):
	if body is Player :
		emit_signal("player_entered", body, checkpoint_priority)



