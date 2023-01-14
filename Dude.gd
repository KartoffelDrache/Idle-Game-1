extends RigidBody2D

func _ready():
	$AnimatedSprite.playing = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
