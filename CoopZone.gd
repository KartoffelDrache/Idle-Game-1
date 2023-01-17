extends Node2D

signal return_HUD
var twales_talk_num = [1,2,3,4,5]
var shut_up = true

func _process(_delta):
	if !visible:
		$TwalesTalk/TextBackground.hide()
		$TwalesTalk/TwalesText.hide()

func _on_TextureButton_pressed():
	emit_signal("return_HUD")

func _on_Twales_twales():
	$Twales/AnimatedSprite.play()
	twalesTalking()
	$TwalesTimer.start()
	$TwalesTalk/TalkTimer.start()
	$TwalesTalk/TextDisappears.start()
	$TwalesTalk/TextBackground.show()
	$TwalesTalk/TwalesText.show()
	

func _on_TwalesTimer_timeout():
	$Twales/AnimatedSprite.stop()
	$Twales/AnimatedSprite.frame = 0

func twalesTalking():
	if shut_up:
		shut_up = false
		var count = randi() % twales_talk_num.size()
		if count == 0:
			$TwalesTalk/TwalesTalk1.play()
		elif count == 1:
			$TwalesTalk/TwalesTalk2.play()
		elif count == 2:
			$TwalesTalk/TwalesTalk3.play()
		elif count == 3:
			$TwalesTalk/TwalesTalk4.play()
		elif count == 4:
			$TwalesTalk/TwalesTalk5.play()

func _on_TalkTimer_timeout():
	shut_up = true

func _on_TextDisappears_timeout():
	$TwalesTalk/TextBackground.hide()
	$TwalesTalk/TwalesText.hide()
