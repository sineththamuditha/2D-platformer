extends Area2D

@export var damage : int = 5
@export var player : Player

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", change_direction)

func _on_body_entered(body):
	for child in body.get_children():
		if (child is Damageable):
			
			var direction = sign((body.global_position - get_parent().global_position).x)
			
			if (direction > 0):
				child.take_damage(damage, Vector2.RIGHT)
			elif (direction < 0):
				child.take_damage(damage, Vector2.LEFT)
			else:
				child.take_damage(damage, Vector2.ZERO) 
			

func change_direction(facing_right : bool):
	for child in get_children():
		if child is FacingCollisionShape:
			if(facing_right):
				child.position = child.facing_right_position
			else:
				child.position = child.facing_left_position
