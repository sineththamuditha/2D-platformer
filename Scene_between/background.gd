extends ParallaxBackground

const scrolling_speed : int = 50

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
