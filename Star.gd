extends RigidBody2D

func _ready():
	var star_type = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = star_type[randi() % star_type.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
