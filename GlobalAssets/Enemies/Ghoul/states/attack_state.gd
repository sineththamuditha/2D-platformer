extends State

class_name AttackStateGhoul

@export var chasing_state : ChasingState
@export var attack_detection : AttackDetection
@export var chasing_detection : Area2D

@onready var attack_timer : Timer = $attack_timer
var near_player : bool = false
var attack_animation : int = 0

var attacking_character : Player = null

func _ready():
	attack_detection.connect("stop_attacking", stop_attacking)

func on_enter():
	near_player = true
	attack_timer.start()
	attack_animation = 0
	chasing_detection.monitoring = false
	
func on_exit():
	attacking_character = null
	chasing_detection.monitoring = true

func stop_attacking(_player : Player):
	near_player = false

func _on_animation_tree_animation_finished(_anim_name):
	if _anim_name == "attack_1" or _anim_name == "attack_2":
		if !near_player :
			next_state = chasing_state
			playback.travel("idle and move")	
		else :
			attack_timer.start()
			attack_animation = (attack_animation + 1) % 2

func attack():
	print("attack is called from attack state")
	match attack_animation:
		0:
			playback.travel("attack_1")
		1:
			playback.travel("attack_2")

func get_direction() :
	if !is_instance_valid(attacking_character) :
		emit_signal("interrupt_state", chasing_state)
		return Vector2.ZERO
	var direction = ((attacking_character.position - player.position).normalized())
	if (direction.x > 0 ):
		return Vector2.RIGHT
	else:
		return Vector2.LEFT


func _on_attack_timer_timeout():
	if near_player :
		attack()
	else :
		next_state = chasing_state
		playback.travel("idle and move")
