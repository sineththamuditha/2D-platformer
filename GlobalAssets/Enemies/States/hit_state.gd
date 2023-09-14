extends State

class_name HitState

@export var damageable : Damageable
@export var death_state : DeathState 
@export var knockback : float = 50.0

@export var ground_state : State
@export var chase_state : State

@onready var hit_timer : Timer = $hit_timer

func _ready():
	damageable.connect("on_hit", get_hit)

func _process(delta):
	pass

func get_hit(node : Node, damage : int, direction : Vector2):
	if damageable.health > 0 :
		player.velocity = knockback * direction
		emit_signal("interrupt_state", self)
		playback.travel("get_hit")

	else:
		emit_signal("interrupt_state", death_state)

func on_enter():
	hit_timer.start()
	
func on_exit():
	hit_timer.stop()
	player.velocity = Vector2.ZERO


func _on_hit_timer_timeout():
	next_state = previous_state
	playback.travel("idle and move")
