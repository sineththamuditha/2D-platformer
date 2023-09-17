extends Area2D

class_name DetectionArea

signal chase_player(player : Player)
signal stop_chasing(player : Player)

func _on_body_entered(body):
	if (body is Player):
		print(body.name + " entered " + self.get_parent().name + " detection")
		emit_signal("chase_player", body)

func _on_body_exited(body):
	if (body is Player):
		print(body.name + " exited " + self.get_parent().name + " detection")
		emit_signal("stop_chasing", body)
