extends Area2D

class_name AttackDetection

signal attack_player(player : Player)
signal stop_attacking(_player : Player)

func _on_body_entered(body):
	print(body.name + " entered " + self.get_parent().name + " attack detection")
	if body is Player :
		emit_signal("attack_player", body)


func _on_body_exited(body):
	print(body.name + " exited " + self.get_parent().name + " attack detection")
	if body is Player :
		emit_signal("stop_attacking", body)
		
