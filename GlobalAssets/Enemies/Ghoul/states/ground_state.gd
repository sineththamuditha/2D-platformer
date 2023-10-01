extends State

@export var detection_area : DetectionArea
@export var chasing_state : ChasingState

func _ready():
	detection_area.connect("chase_player", switch_to_chase)
	
func switch_to_chase(_player : Player):
	chasing_state.chasing_character = _player
	emit_signal("interrupt_state", chasing_state)
