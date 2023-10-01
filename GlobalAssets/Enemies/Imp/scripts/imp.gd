extends CharacterBody2D

class_name Imp

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = $imp_sprite
@onready var animation_tree : AnimationTree = $animation_tree
@onready var imp_state_machine : PlayerStateMachine = $imp_state_machine
@onready var hit_state : HitState = $imp_state_machine/hit_state

signal facing_direction_change(facing_right : bool)

var direction : Vector2

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	
	if position.y > 1000:
		queue_free()
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if imp_state_machine.current_state is ChasingState or imp_state_machine.current_state is ImpAttackState:
		direction = imp_state_machine.current_state.get_direction()
	else:
		direction = Vector2.ZERO
		
	if(direction && imp_state_machine.can_move()):
		velocity.x = direction.x * SPEED
	elif (imp_state_machine.current_state != hit_state):
		velocity.x = move_toward(velocity.x,0, SPEED)

	move_and_slide()
	update_animation()
	update_facing_direction()
	

func update_animation():
	animation_tree.set("parameters/idle and move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	
	emit_signal("facing_direction_change", !animated_sprite.flip_h)

