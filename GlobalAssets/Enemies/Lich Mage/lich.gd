extends CharacterBody2D

class_name Lich

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const knockback = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = $lich_sprite
@onready var animation_tree : AnimationTree = $animation_tree
@onready var lich_state_machine : PlayerStateMachine = $lich_state_machine
@onready var damageable : Damageable = $Damageable
@onready var death_state : DeathState = $lich_state_machine/dead_state

var direction : Vector2

signal facing_direction_change(facing_right : bool)

func _ready():
	animation_tree.active = true
	damageable.connect("on_hit", get_hit)

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		
	if lich_state_machine.current_state is ChasingState or lich_state_machine.current_state is LichAttackState:
		direction = lich_state_machine.current_state.get_direction()
	else:
		direction = Vector2.ZERO
		
	if(direction && lich_state_machine.can_move()):
		velocity.x = direction.x * SPEED
	else :
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

func get_hit(_node : Node, _damage : int, _direction : Vector2):
	if damageable.health > 0 :
		self.velocity = knockback * direction

	else:
		lich_state_machine.current_state.emit_signal("interrupt_state", death_state)
