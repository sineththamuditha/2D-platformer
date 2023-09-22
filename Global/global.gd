extends Node
var current_scene = null

var player_health : int
var potion_count : int

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	player_health = 100
	potion_count = 0
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	
	current_scene.free()
	
	var s = ResourceLoader.load(path)

	current_scene = s.instantiate()

	get_tree().root.add_child(current_scene)

	get_tree().current_scene = current_scene

func set_player_health( amount : int ) :
	player_health = amount
	
func change_potion_count() :
	potion_count += 1
