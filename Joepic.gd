extends TextureRect

export(float) var sky_speed = -0.1
var starting_point

func _ready():
	self.global_position = starting_point

func _process(delta) -> void:
	self.motion_offset.x += sky_speed * delta

func _on_Reset_timeout():
	pass # Replace with function body.
