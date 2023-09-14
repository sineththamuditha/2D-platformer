extends State

class_name AttackState

@export var ground_state : State
@export var crouch_state : State

@onready var attack_timer : Timer = $attack_timer

var on_air : bool = false

# enum to ckeck the attack chain
enum ATTACKCHAIN {
	ATTACK_1,
	ATTACK_2,
	ATTACK_3,
	ATTACK_4,
	AIR_ATTACK,
	CROUCH_ATTACK_1,
	CROUCH_ATTACK_2
}
var attack_chain : ATTACKCHAIN

func state_process(delta):
	if on_air and player.is_on_floor():
		playback.travel("attack_from_air_end")

func state_input(event : InputEvent):
	if (event.is_action_pressed("attack")) and attack_chain != ATTACKCHAIN.AIR_ATTACK:
		attack_timer.stop()
		attack_timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "attack_1" || anim_name == "attack_2" || anim_name == "attack_3"):
		if (attack_timer.is_stopped()):
			next_state = ground_state
		else:
			attack()

	if (anim_name == "attack_4"):
		next_state = ground_state
	
	if (anim_name == "attack_from_air_end"):
		next_state = ground_state
		
	if (anim_name == "crouch_attack_1"):
		if (attack_timer.is_stopped()):
			next_state = crouch_state
		else:
			attack()
	
	if (anim_name == "crouch_attack_2"):
		next_state = crouch_state

func on_exit():	
	if (attack_chain == ATTACKCHAIN.CROUCH_ATTACK_1 || attack_chain == ATTACKCHAIN.CROUCH_ATTACK_2):
		playback.travel("crouch_idle")
	else:
		playback.travel("idle and move")
	on_air = false
	attack_timer.stop()

func attack():
	attack_timer.stop()
	match attack_chain:
		ATTACKCHAIN.ATTACK_1:
			playback.travel("attack_2")
			attack_chain = ATTACKCHAIN.ATTACK_2
			
		ATTACKCHAIN.ATTACK_2:
			playback.travel("attack_3")
			attack_chain = ATTACKCHAIN.ATTACK_3
			
		ATTACKCHAIN.ATTACK_3:
			playback.travel("attack_4")
			attack_chain = ATTACKCHAIN.ATTACK_4
			
		ATTACKCHAIN.CROUCH_ATTACK_1:
			playback.travel("crouch_attack_2")
			attack_chain = ATTACKCHAIN.CROUCH_ATTACK_2

