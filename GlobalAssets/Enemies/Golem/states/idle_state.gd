extends State

@export var detection_area : DetectionArea
@export var chasing_state : ChasingState

func _ready():
	detection_area.connect("chase_player", chase_player)
	
func chase_player(_player : Player):
	next_state = chasing_state
	chasing_state.chasing_character = player
