extends RichTextLabel

@export var float_speed : Vector2 = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += float_speed


func _on_health_timer_timeout():
	queue_free()
