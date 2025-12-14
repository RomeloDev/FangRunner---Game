extends ParallaxBackground

var scrolling_speed = 100

func _process(delta: float) -> void:
	scroll_offset.x -= scrolling_speed * delta
