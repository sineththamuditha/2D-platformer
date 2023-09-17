extends Node

class_name CheckpointManager

var current_checkpoint_priority : int

signal change_checkpoint( checkpooint_position : Vector2)

func _ready():
	current_checkpoint_priority = -1
	
	for child in get_children() :
		if child is Checkpoint :
			child.connect("player_entered", check_checkpoint)
		else :
			push_warning(child.name + "is not a checkpoint")

func check_checkpoint(player : Player, checkpoint_priority : int) :
	if checkpoint_priority > current_checkpoint_priority :
		emit_signal("change_checkpoint", player.position)
