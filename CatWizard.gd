extends Area2D

signal foxish_learned
signal blood_low
var mouse_over = false
var shop_open = false
var sold = false
var idle_force = false
var blood_check = false

func _process(_delta):
	if idle_force:
		$AnimatedSprite.animation = "Idle"
	elif sold:
		$AnimatedSprite.animation = "Sold"
	elif shop_open:
		$AnimatedSprite.animation = "ShopOpen"
	if Input.is_action_pressed("click") && mouse_over && shop_open && blood_check && !sold:
		print_debug("Meow")
		sold = true
		$BackToIdleTimer.start()
		emit_signal("foxish_learned")
	elif Input.is_action_pressed("click") && mouse_over && shop_open && !sold:
		emit_signal("blood_low")

func _on_CatWizard_mouse_exited():
	mouse_over = false


func _on_CatWizard_mouse_entered():
	mouse_over = true

func _on_PauseScreen_open_shop():
	shop_open = true

func _on_BackToIdleTimer_timeout():
	idle_force = true


func _on_PauseScreen_blood_count(blood):
	if blood > 15000:
		blood_check = true
