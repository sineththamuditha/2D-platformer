extends Area2D

class_name CastDetection

signal switch_to_cast(player : Player)
signal switch_to_chase(player : Player)

const damage : int = 15

func _on_body_entered(body):
	for child in body.get_children() :
		if child is PlayerDamageable :
			emit_signal("switch_to_cast", body)


func _on_body_exited(body):
	for child in body.get_children() :
		if child is PlayerDamageable :
			emit_signal("switch_to_chase", body)
