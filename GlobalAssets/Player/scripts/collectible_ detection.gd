extends Area2D

class_name CollectibleDetection

signal pickup_health_potion()

func _on_area_entered(area):
	if area.get_parent() is HealthPotion :
		area.get_parent().queue_free()
		emit_signal("pickup_health_potion")
		Global.change_potion_count()
