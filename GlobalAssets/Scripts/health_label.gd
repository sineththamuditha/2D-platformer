extends RichTextLabel

@export var float_speed : Vector2 = Vector2(0,-1)

func _process(_delta):
	position += float_speed


func _on_health_timer_timeout():
	queue_free()
