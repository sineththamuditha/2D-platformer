extends Damageable

class_name PlayerDamageable

func _ready():
	health = 50

func take_damage(damage : int, direction : Vector2):
	health -= damage
	
	emit_signal("on_hit",get_parent(), damage, direction)
	

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "death"):
		get_parent().queue_free()
