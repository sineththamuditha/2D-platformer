extends State

class_name ImpAttackState

@export var chasing_state : ChasingState
@export var attack_detection : AttackDetection 
@export var detection_area : DetectionArea

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
	detection_area.monitoring = false

func on_exit():
	attacking_character = null
	detection_area.monitoring = true

func stop_attacking(_player : Player):
	near_player = false

func state_process(_delta):
	if attack_timer.is_stopped():
		attack()

func _on_animation_tree_animation_finished(_anim_name):
	if !near_player :
		next_state = previous_state
		playback.travel("idle and move")
		return
		
	else:
		attack_animation = (attack_animation + 1) % 2
	

func attack():
	match attack_animation:
		0:
			playback.travel("attack_2")
		1:
			playback.travel("attack_1")
	
	attack_timer.start()

func get_direction() :
	if !is_instance_valid(attacking_character) :
		emit_signal("interrupt_state", chasing_state)
		return Vector2.ZERO
	var direction = ((attacking_character.position - player.position).normalized())
	if (direction.x > 0 ):
		return Vector2.RIGHT
	else:
		return Vector2.LEFT
