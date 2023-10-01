extends State

class_name AirState

const DOUBLE_JUMP_VELOCITY = -400.0

@export var ground_state : GroundState
@export var attack_state : AttackState
@export var jump_sound : AudioStreamPlayer2D

var has_double_jump : bool = false

func state_process(_delta):
	if(player.is_on_floor()):
		next_state = ground_state 

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")) && not has_double_jump:
		double_jump()
	
	if(event.is_action_pressed("attack")):
		attack()

func on_exit():
	if (next_state == ground_state):
		has_double_jump = false

func double_jump():
	jump_sound.play()
	player.velocity.y = DOUBLE_JUMP_VELOCITY
	has_double_jump = true
	playback.travel("double jump")

func attack():
	playback.travel("attack_from_air")
	next_state = attack_state
	attack_state.attack_chain = attack_state.ATTACKCHAIN.AIR_ATTACK
	attack_state.on_air = true
