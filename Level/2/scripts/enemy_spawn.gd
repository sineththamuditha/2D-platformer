extends Area2D

@export var golem : PackedScene
@export var enemies : Node
@onready var triggered : bool = false

func _on_body_entered(body) -> void :
	
	if triggered == true :
		return
	
	triggered = true
	
	var golem_1 = golem.instantiate()
	var golem_2 = golem.instantiate()
	
	golem_1.name = "spawned_golem#1"
	golem_2.name = "spawned_golem#2"
	
	enemies.add_child.call_deferred(golem_1)
	enemies.add_child.call_deferred(golem_2)
	
	golem_1.position = body.position + Vector2(150,0)
	golem_2.position = body.position + Vector2(-150,0)
	
	
