extends CollisionShape2D

class_name FacingCollisionShape

@onready var player = get_parent().get_parent()

@onready var facing_left_position : Vector2 = Vector2(-self.position.x,self.position.y)
@onready var facing_right_position : Vector2 = Vector2(self.position.x,self.position.y)

