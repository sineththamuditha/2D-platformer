extends Node

class_name State

const JUMP_VELOCITY = -400.0

@export var can_move : bool = true

var player : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State
var previous_state : State

signal interrupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_exit():
	pass
	
func on_enter():
	pass 
