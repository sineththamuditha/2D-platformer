extends Area2D

class_name GolemAttack

@export var golem : Golem

@export var damage : int = 5

func _ready():
	golem.connect("facing_direction_change", change_attack_boxes)


func change_attack_boxes(facing_right : bool):
	for child in get_children():
		if child is FacingCollisionShape:
			if(facing_right):
				child.position = child.facing_right_position
			else:
				child.position = child.facing_left_position


func _on_body_entered(body):
	for child in body.get_children():
		if child is PlayerDamageable:
			child.take_damage(damage, Vector2.ZERO)


