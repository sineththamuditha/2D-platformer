extends State

class_name CrouchState

@export var ground_state : GroundState
@export var attack_state : AttackState

@onready var crouch_timer : Timer = $crouch_timer

signal crouch_finished()

func state_process(delta):
	if crouch_timer.is_stopped():
		can_move = true

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		stand()

	if (event.is_action_pressed("attack")):
		attack()

func stand():
	next_state = ground_state
	playback.travel("idle and move")

func attack():
	next_state = attack_state
	playback.travel("crouch_attack_1")
	attack_state.attack_chain = attack_state.ATTACKCHAIN.CROUCH_ATTACK_1


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "roll":
		crouch_timer.start()
		can_move = false
		emit_signal("crouch_finished")
