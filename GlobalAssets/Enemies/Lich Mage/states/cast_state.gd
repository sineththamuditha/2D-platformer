extends State

class_name CastState

@export var chasing_state : ChasingState
@export var attcking_state : State
@export var cast_area_detection : Area2D
@export var fire_ball_scene : PackedScene
@export var lich : Lich

@onready var cast_timer : Timer = $cast_timer
@onready var fireball_timer : Timer = $fireball_timer

var cast_animation : int 
var player_near : bool
var lich_sprite : AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	cast_area_detection.connect("switch_to_cast", switch_to_cast_state)
	cast_area_detection.connect("switch_to_chase", switch_to_chase_state)
	lich_sprite = lich.get_child(0)


func on_enter():
	cast_animation = 0
	player_near = true
	
func state_process(_delta):
	if cast_timer.is_stopped() :
		cast_a_fireball()

func switch_to_cast_state(_player : Player):
	emit_signal("interrupt_state", self)
	
func switch_to_chase_state(_player : Player):
	player_near = false

func cast_a_fireball() :
	match cast_animation :
		0 :
			playback.travel("cast_1")
		1 :
			playback.travel("cast_2")
	
	cast_animation = (cast_animation + 1) % 2
	cast_timer.start()
	fireball_timer.start()

func send_a_fireball() :
	var fire_ball : StaticBody2D = fire_ball_scene.instantiate()
	lich.get_parent().add_child(fire_ball)
	
	if lich_sprite.flip_h :
		fire_ball.flip()
		fire_ball.position = lich.position + Vector2(-90,-25)
	else :
		fire_ball.position = lich.position + Vector2(90,-25)


func _on_fireball_timer_timeout():
	send_a_fireball()


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "cast_1" or anim_name == "cast_2" :
		if not player_near :
			emit_signal("interrupt_state", chasing_state)
