extends RigidBody2D

#var fixed_y = 568

#func _fixed_process(delta):
#	position = Vector2(position.x, fixed_y)

func _on_BouncePad_body_entered(body):
	var bounce_modes = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = "bounce"
	$Timer.start()

func _on_Timer_timeout():
	var bounce_modes = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = "ready"
