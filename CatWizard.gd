extends Area2D

var mouse_over = false

func _process(_delta):
	if Input.is_action_pressed("click") && mouse_over:
		print_debug("Meow")

func _on_CatWizard_mouse_exited():
	mouse_over = false


func _on_CatWizard_mouse_entered():
	mouse_over = true
