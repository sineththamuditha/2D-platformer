extends Camera2D

class_name PlayerCamera


func set_camera_limits( left : int, right : int, top : int, bottom : int) -> void :
	limit_left = left
	limit_right = right
	limit_top = top
	limit_bottom = bottom
	

func change_zoom(new_zoom_level : Vector2) -> void :
	zoom = new_zoom_level
