extends State

@export var detection_area : DetectionArea
@export var chasing_state : ChasingState

@onready var look_around_timer : Timer = $look_around_timer

func _ready():
	detection_area.connect("chase_player", chase_player)
	
func state_process(delta):
	if look_around_timer.is_stopped() :
		playback.travel("look_around")
		look_around_timer.start()
	
func chase_player(player : Player):
	print("here")
	next_state = chasing_state
	chasing_state.chasing_character = player

func on_enter():
	look_around_timer.start()

func on_exit():
	look_around_timer.stop()
