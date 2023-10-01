extends CanvasLayer

class_name GUI

@onready var potion_label : Label = $Potions/count
@onready var dialog_box : Label = $text_box_player/dialog
@onready var player_name : Label = $text_box_player/player_name
@onready var mission_details : Node = $mission_details

var active_text_box : Node

func _ready():
	var potion_counter = get_parent().get_node("Player/potion_counter");
	if  is_instance_valid(potion_counter) :
		potion_counter.connect("update_potion_count", update_potion_count)


func update_potion_count(potion_count : int) -> void :
	potion_label.text = str(potion_count)

func show_dialogue(message : String, text_box : String) -> void :
	active_text_box = get_node("text_box_player/" + text_box)
	active_text_box.visible = true
	dialog_box.text = message
	dialog_box.visible = true
	player_name.visible = true

func close_dialogue() -> void :
	if is_instance_valid(active_text_box) :
		active_text_box.visible = false
	dialog_box.visible = false
	player_name.visible = false

func show_mission_info(description : String, objectives : Array, notes : Array) -> void :
	var description_label : Label = mission_details.get_node("description")
	description_label.text = description
	
	var objectives_label : Label = mission_details.get_node("objectives")
	objectives_label.text = format_array_to_string(objectives)
	
	var notes_label : Label = mission_details.get_node("notes")
	notes_label.text = format_array_to_string(notes)
	
	for child in mission_details.get_children() :
		child.visible = true

func close_mission_info() -> void :
	for child in mission_details.get_children() :
		child.visible = false

func format_array_to_string(arr : Array) -> String :
	var fmt_str : String = ""
	for str in arr :
		fmt_str += " - " + str + "\n"
	return fmt_str
