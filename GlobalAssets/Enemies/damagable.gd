extends Node

class_name Damageable

signal on_hit(node : Node, damage : int, direction : Vector2)

var can_get_hit : bool = true

@onready var damage_timer : Timer = $damage_timer

@export var health : int = 20 :
	get:
		return health
	set(value):
		Signals.emit_signal("on_health_change", get_parent(), value - health)
		health = value

func take_damage(damage : int, direction : Vector2):
	if damage_timer.is_stopped() :
		damage_timer.start()
		health -= damage
		emit_signal("on_hit",get_parent(), damage, direction)
	

func _on_animation_tree_animation_finished(anim_name):	
	if (anim_name == "death"):
		get_parent().queue_free()
