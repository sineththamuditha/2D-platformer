extends CharacterBody2D

class_name Ghoul

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = $ghoul_sprite
@onready var animation_tree : AnimationTree = $animation_tree
@onready var ghoul_state_machine : PlayerStateMachine = $ghoul_state_machine
@onready var hit_state : HitState

var direction : Vector2

signal facing_direction_change(facing_right : bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	
	if position.y > 1000:
		queue_free()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if ghoul_state_machine.current_state is ChasingState or ghoul_state_machine.current_state is AttackStateGhoul:
		direction =  ghoul_state_machine.current_state.get_direction()
	else:
		direction = Vector2.ZERO
	
	if direction and ghoul_state_machine.can_move() :
		velocity.x = direction.x * SPEED
	elif ghoul_state_machine.current_state != hit_state :
		velocity.x = move_toward(velocity.x,0, SPEED)
	
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/idle and move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0 :
		animated_sprite.flip_h = false
	elif direction.x < 0 :
		animated_sprite.flip_h = true
	
	emit_signal("facing_direction_change", !animated_sprite.flip_h)
