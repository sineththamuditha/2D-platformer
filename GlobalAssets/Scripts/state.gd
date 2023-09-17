extends Node

class_name State

const JUMP_VELOCITY = -400.0

@export var can_move : bool = true

var player : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback

@onready var next_state : State = null
@onready var previous_state : State = null

signal interrupt_state(new_state : State)

func state_process(_delta):
	pass

func state_input(_event : InputEvent):
	pass

func on_exit():
	pass
	
func on_enter():
	pass 
