extends Node

var dialogues : Dictionary
var instructions : Dictionary

func _ready():
	var dialogue_file = FileAccess.open("res://Global/dialogues.txt",FileAccess.READ)
	if is_instance_valid(dialogue_file) :
		var texts = JSON.parse_string(dialogue_file.get_as_text())
		dialogues = texts["dialogues"]
		instructions = texts["instructions"]
		

func get_dialogues() -> Array :
	return dialogues[str(Global.current_level)]

func get_instructions() -> Dictionary :
	return instructions[str(Global.current_level)]
