extends State

class_name GroundState

@export var damageable : PlayerDamageable
@export var air_state : AirState
@export var attack_state : AttackState
@export var crouch_state : CrouchState
@export var death_state : PlayerDeadState
@export var jump_sound : AudioStreamPlayer2D
@export var hurt_sound : AudioStreamPlayer2D
@onready var ground_timer : Timer = $ground_timer

func _ready():
	damageable.connect("on_hit", get_hit)

func state_process(_delta):
	if(!player.is_on_floor() and ground_timer.is_stopped()):
		next_state = air_state 

func state_input(event : InputEvent):
	if player.conversing :
		return
	
	if (event.is_action_pressed("jump")):
		jump()
		
	if (event.is_action_pressed("attack")):
		attack()

	if (event.is_action_pressed("crouch")):
		crouch()
		
func on_enter():
	ground_timer.start()
	
func jump():
	player.velocity.y = JUMP_VELOCITY
	next_state = air_state
	jump_sound.play()
	playback.travel("jump")
	
func attack():
	next_state = attack_state
	playback.travel("attack_1")
	attack_state.attack_chain = attack_state.ATTACKCHAIN.ATTACK_1
	
func crouch():
	next_state = crouch_state
	playback.travel("crouch_idle")

func get_hit(_player : Node, _damage : int, _direction : Vector2):
	if damageable.health > 0 :
		hurt_sound.play()
		
	else:
		next_state = death_state
		playback.travel("death")
		
