extends Area2D

class_name AttackDetection

signal attack_player(player : Player)
signal stop_attacking(player : Player)

func _on_body_entered(body):
	for child in body.get_children():
		if (child is PlayerDamageable):
			emit_signal("attack_player", body)


func _on_body_exited(body):
	for child in body.get_children():
		if (child is PlayerDamageable):
			emit_signal("stop_attacking", body)
