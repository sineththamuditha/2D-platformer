extends Node

class_name PlayerStateMachine

@export var player : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State 

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.player = player
			child.playback = animation_tree["parameters/playback"]
			
			child.connect("interrupt_state", handle_interrupt)
			
		else:
			push_warning("Child " + child.name + " is not a state")

func _physics_process(delta):
	if (current_state.next_state != null):
		switch_states(current_state.next_state)

	current_state.state_process(delta)

func can_move():
	return current_state.can_move

func switch_states(next_state : State):
	if current_state.is_final():
		return
		
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		next_state.previous_state = current_state
	
	print(name + " goes to " + next_state.name + " from " + current_state.name)
	current_state = next_state
	
	current_state.on_enter()

func _input(event : InputEvent):
	current_state.state_input(event)

func handle_interrupt(new_state : State):
	print("By interrupt from " + current_state.name)
	switch_states(new_state)
