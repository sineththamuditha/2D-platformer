extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite : AnimatedSprite2D = $player_animation_sprite
@onready var animation_tree : AnimationTree = $animation_tree
@onready var player_state_machine : PlayerStateMachine = $player_state_machine

@export var crouch_state : CrouchState

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && player_state_machine.can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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
		
	emit_signal("facing_direction_changed", !animated_sprite.flip_h)

