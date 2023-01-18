extends Node2D

signal return_HUD
signal TwalesTalked
var twales_talk_num = [1,2,3,4,5]
var shut_up = true
var foxish_learned = false
var twales_messages = ["Twales the Fox:\nAh finally, it seems you can understand me now","Twales the Fox:\nThis looks like a lovely coop but you seem to have no chickens","Twales the Fox:\nI can help you with that for a small price of 20k blood"]
var message_count = 0

func _process(_delta):
	if message_count == 4:
		$UI/ChickenSign.show()
	if !visible:
		$UI/TwalesTalk/TextBackground.hide()
		$UI/TwalesTalk/TwalesText.hide()
		$UI/ChickenSign.hide()
	

func _on_ReturnButton_pressed():
	emit_signal("return_HUD")

func _on_Twales_twales():
	emit_signal("TwalesTalked")
	twalesTalking()
	if message_count == 4:
		$UI/TwalesTalk/TwalesText.hide()
		$UI/TwalesTalk/TextBackground.hide()
	else:
		$UI/TwalesTalk/TextBackground.show()
		$UI/TwalesTalk/TwalesText.show()

	

func _on_TwalesTimer_timeout():
	$UI/Twales/AnimatedSprite.stop()
	$UI/Twales/AnimatedSprite.frame = 0

func twalesTalking():
	if shut_up:
		shut_up = false
		if message_count < 3:
			$UI/Twales/AnimatedSprite.play()
			$UI/TwalesTimer.start()
			var count = randi() % twales_talk_num.size()
			$UI/TwalesTalk/TalkTimer.start()
			$UI/TwalesTalk/TextDisappears.start()
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
			if foxish_learned:
				$UI/TwalesTalk/TwalesText.text = twales_messages[message_count]
		if foxish_learned && message_count < 4:
			message_count += 1
		

func _on_TalkTimer_timeout():
	shut_up = true

func _on_TextDisappears_timeout():
	$UI/TwalesTalk/TextBackground.hide()
	$UI/TwalesTalk/TwalesText.hide()

func _on_PauseScreen_foxish_learned():
	foxish_learned = true
