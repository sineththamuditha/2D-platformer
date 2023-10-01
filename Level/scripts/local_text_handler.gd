extends Node

class_name LocalTextHandler

@export var dialogue_box_color : String

@onready var gui : GUI

var dialogues : Array
var current_dialogue : int
var instructions : Dictionary

func _ready():
	dialogues = TextManager.get_dialogues()
	instructions = TextManager.get_instructions()
	current_dialogue = 0
	gui = get_parent().get_node("GUI")

func show_dialogue() :
	gui.show_dialogue(dialogues[current_dialogue], dialogue_box_color)
	current_dialogue += 1

func close_dialogue() -> void :
	gui.close_dialogue()

func show_level_info() :
	gui.show_mission_info(instructions["description"], instructions["objectives"], instructions["notes"])
	
func close_level_info() :
	gui.close_mission_info()
