extends CharacterBody2D

class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite : AnimatedSprite2D = $player_animation_sprite
@onready var animation_tree : AnimationTree = $animation_tree
@onready var player_state_machine : PlayerStateMachine = $player_state_machine
@onready var ground_state : GroundState = $player_state_machine/ground
@onready var player_damageable : PlayerDamageable = $player_damageable
@onready var potion_label : Label = $potion_count

@export var crouch_state : CrouchState

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var last_checkpoint : Vector2
var checkpoint_manager : CheckpointManager

signal facing_direction_changed(facing_right : bool)
signal consume_potion()

func _ready():
	animation_tree.active = true
	last_checkpoint = position
	
	var check_point_manager = get_parent().get_node("checkpoint_manager")
	
	if is_instance_valid(check_point_manager) :
		check_point_manager.connect("change_checkpoint", change_checkpoint)

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("heal") :
		heal()

	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && player_state_machine.can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if position.y > 1000 :
		reset_ground_position()
	
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

func reset_ground_position() :
	position = last_checkpoint
	player_damageable.take_damage( 10, Vector2.ZERO)

func change_checkpoint(new_checkpoint) :
	last_checkpoint = new_checkpoint 

func heal() :
	if potion_label.potion_count != 0 :
		emit_signal("consume_potion")
		player_damageable.take_damage( -20, Vector2.ZERO)
