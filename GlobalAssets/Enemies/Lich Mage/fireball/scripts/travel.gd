extends StaticBody2D

const speed : int = 100

var direction : Vector2

@onready var animation_player : AnimationPlayer = $animation_player
@onready var fire_ball_timer : Timer = $fire_ball_timer

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
