extends ParallaxLayer

export(float) var sky_speed = -2.0

func _process(delta) -> void:
	self.motion_offset.x += sky_speed * delta
