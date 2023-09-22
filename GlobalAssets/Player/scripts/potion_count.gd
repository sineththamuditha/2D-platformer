extends Label

@export var potion_detection_area : CollectibleDetection

var potion_count : int

func _ready():
	potion_detection_area.connect("pickup_health_potion", pickup_health_potion)
	get_parent().connect("consume_potion", consume_potion)
	potion_count = Global.potion_count
	text = "Potions : " + str(potion_count)


func pickup_health_potion() :
	potion_count += 1
	text = "Potions : " + str(potion_count)
	
func consume_potion() :
	potion_count -= 1
	text = "Potions : " + str(potion_count)
