extends Area2D

signal twales
var mouse_over = false

func _input(_event):
	if mouse_over and Input.is_action_pressed("click"):
		emit_signal("twales")

func _on_Twales_mouse_entered():
	mouse_over = true

func _on_Twales_mouse_exited():
	mouse_over = false
