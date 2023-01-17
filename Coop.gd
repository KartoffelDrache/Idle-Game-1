extends AnimatedSprite

signal coop_switch
var mouse_over = false

func _input(_event):
	if mouse_over and Input.is_action_pressed("click"):
		emit_signal("coop_switch")

func _on_Area2D_mouse_entered():
	mouse_over = true


func _on_Area2D_mouse_exited():
	mouse_over = false
