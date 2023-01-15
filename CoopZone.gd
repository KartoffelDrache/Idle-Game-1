extends Node2D

signal return_HUD

func _on_TextureButton_pressed():
	emit_signal("return_HUD")
