extends KinematicBody2D

signal bounce

func _ready():
	$AnimatedSprite.stop()

func _on_Area2D_body_entered(_body):
	$AnimatedSprite.play("Bounce")
	emit_signal("bounce")

func _on_Area2D_body_exited(_body):
	$AnimatedSprite.play("Ready")
