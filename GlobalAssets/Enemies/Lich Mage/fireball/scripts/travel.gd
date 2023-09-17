extends StaticBody2D

const speed : int = 100

@export var direction : Vector2

@onready var animation_player : AnimationPlayer = $animation_player
@onready var fire_ball_timer : Timer = $fire_ball_timer
@onready var fireball_trail : AnimatedSprite2D = $fireball_trail
@onready var fireball_sprite : AnimatedSprite2D = $fireball_sprite
@onready var fireball_collision : CollisionShape2D = $fireball_collision/collision_body

func _ready():
	animation_player.play("travel")
	direction = Vector2.RIGHT
	fire_ball_timer.start()

func _physics_process(delta):
	position += speed * direction * delta


func _on_fireball_collision_body_entered(body):
	for child in body.get_children():
		if child is PlayerDamageable :
			
			
			
			child.take_damage(10, Vector2.ZERO)
	
	queue_free()


func _on_fire_ball_timer_timeout():
	queue_free()

func flip():
	direction = Vector2.LEFT
	fireball_sprite.flip_h = true
	fireball_trail.flip_h = true
	fireball_trail.position = Vector2(-fireball_trail.position.x, fireball_trail.position.y)
	fireball_collision.position = Vector2(-fireball_collision.position.x, fireball_collision.position.y)
