extends Control

class_name HealthManager

const damage_color : Color = Color.RED
const heal_color : Color = Color.GREEN

@export var health_label : PackedScene

func _ready():
	Signals.connect("on_health_change", change_health)

func change_health(node : Node, health_change : int):
	var label_instance : RichTextLabel = health_label.instantiate()
	node.add_child.call_deferred(label_instance)
	label_instance.text = str(health_change)
	
	if (health_change > 0):
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
