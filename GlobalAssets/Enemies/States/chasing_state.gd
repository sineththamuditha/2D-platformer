extends State

class_name ChasingState

@export var detection_area : DetectionArea
@export var idle_state : State
@export var attack_state : State
@export var attack_detection : AttackDetection

var chasing_character : CharacterBody2D = null

func _ready():
	detection_area.connect("stop_chasing", stop_chasing)
	attack_detection.connect("attack_player", attack_player)

func state_process(delta):
	pass

func stop_chasing(player : Player):
	next_state = idle_state

func get_direction():
	var direction = ((chasing_character.position - player.position).normalized())
	if (direction.x > 0 ):
		return Vector2.RIGHT
	else:
		return Vector2.LEFT

func attack_player(player : Player):
	emit_signal("interrupt_state", attack_state)
	#attack_state.attacking_character = player
	playback.travel("attack_1")