extends Node2D

signal return_HUD
var twales_talk_num = [1,2,3,4,5]
var shut_up = true

func _process(_delta):
	if !visible:
		$UI/TwalesTalk/TextBackground.hide()

func _on_ReturnButton_pressed():
	emit_signal("return_HUD")

func _on_Twales_twales():
	$UI/Twales/AnimatedSprite.play()
	twalesTalking()
	$UI/TwalesTimer.start()
	$UI/TwalesTalk/TalkTimer.start()
	$UI/TwalesTalk/TextDisappears.start()
	$UI/TwalesTalk/TextBackground.show()
	$UI/TwalesTalk/TwalesText.show()
	

func _on_TwalesTimer_timeout():
	$UI/Twales/AnimatedSprite.stop()
	$UI/Twales/AnimatedSprite.frame = 0

func twalesTalking():
	if shut_up:
		shut_up = false
		var count = randi() % twales_talk_num.size()
		if count == 0:
			$UI/TwalesTalk/TwalesTalk1.play()
		elif count == 1:
			$UI/TwalesTalk/TwalesTalk2.play()
		elif count == 2:
			$UI/TwalesTalk/TwalesTalk3.play()
		elif count == 3:
			$UI/TwalesTalk/TwalesTalk4.play()
		elif count == 4:
			$UI/TwalesTalk/TwalesTalk5.play()

func _on_TalkTimer_timeout():
	shut_up = true

func _on_TextDisappears_timeout():
	$UI/TwalesTalk/TextBackground.hide()
	$UI/TwalesTalk/TwalesText.hide()
