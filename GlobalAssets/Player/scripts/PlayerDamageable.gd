extends Damageable

class_name PlayerDamageable

func _ready():
	health = Global.player_health

func take_damage(damage : int, direction : Vector2):
	health -= damage
	
	if health > 100 :
		health = 100
	
	Global.set_player_health(health)
	
	emit_signal("on_hit",get_parent(), damage, direction)
	

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "death"):
		get_parent().queue_free()
