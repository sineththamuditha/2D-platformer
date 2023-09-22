extends Area2D

@export var golem : PackedScene
@export var ghoul : PackedScene
@export var spider : PackedScene
@export var enemies : Node

@onready var triggered : bool = false
@onready var spawning_rounds : int = 3
@onready var spawned_enemies : Array = []

var player : Player

func _process(_delta) -> void :
	
	if spawning_rounds == 0 :
		queue_free()
	
	if spawned_enemies.is_empty() :
		match spawning_rounds :
			2 :
				spawn_and_position_enemies( ghoul, "ghoul")
			1 :
				spawn_and_position_enemies( golem, "golem")
			_ :
				return
	
	if !is_instance_valid(spawned_enemies[0]) :
		spawned_enemies.pop_front()

func _on_body_entered(body):
	if triggered :
		return
		
	if body is Player :
		triggered = true
		player = body
		spawn_and_position_enemies( spider, "spider")

func spawn_and_position_enemies(enemy_type : PackedScene, enemy_name : String) -> void :
	
	var enemy_1 = enemy_type.instantiate()
	var enemy_2 = enemy_type.instantiate()
	
	enemy_1.name = "spawned_" + enemy_name + "#1"
	enemy_2.name = "spawned_" + enemy_name + "#2"
	
	enemies.add_child.call_deferred(enemy_1)
	enemies.add_child.call_deferred(enemy_2)
	
	enemy_1.position = player.position + Vector2(250, 0)
	enemy_2.position = player.position + Vector2(-250, 0)
	
	spawned_enemies.push_back(enemy_1)
	spawned_enemies.push_back(enemy_2)
	
	spawning_rounds -= 1
