extends Node

#hi max! hi max! hi max!
#func _ready():
#func _process(delta):
var file_data
var cursor_val = 1
signal saving
signal loaded
var arrow1 = load("res://SMILEYSNICKER1.png")
var arrow2 = load("res://SMILEYSNICKER2.png")
var arrow3 = load("res://SMILEYSNICKER3.png")
var arrow4 = load("res://SMILEYSNICKER4.png")
var pointer = load("res://SMILEYSNICKER5.png")

func _ready():
	$Music.play()
	$MiceChange.start()
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND)


func _on_HUD_paused():
	$HUD.hide()
	$PauseScreen.show()

func _on_PauseScreen_resume():
	$HUD.show()
	$PauseScreen.hide()

func _on_PauseScreen_save():
	emit_signal("saving")

func _on_HUD_saving(knives,blood):
	save(knives,blood)

func _on_HUD_loading():
	loading()

func save(knives,blood):
	file_data = {"knives":knives,"blood":blood}
	
	var file = File.new()
	file.open("./data.json", File.WRITE)
	file.store_line(to_json(file_data))
	file.close()
	
func loading():
	var file = File.new()
	file.open("./data.json",File.READ)
	var data = parse_json(file.get_as_text())
	file_data = data
	var loadknives = file_data.knives
	var loadblood = file_data.blood
	emit_signal("loaded",loadknives,loadblood)

func _on_PauseScreen_volume(volume):
	$Music.set_volume_db(volume)
	$Music2.set_volume_db(volume)
	$Whaleloop.set_volume_db(volume)
	
func _on_PauseScreen_musicChange():
	if $Music.playing:
		$Music.stop()
		$Music2.play()
	elif $Music2.playing:
		$Music2.stop()
		$Whaleloop.play()
	elif $Whaleloop.playing:
		$Whaleloop.stop()
		$Music.play()

func _on_PauseScreen_spin():
	$Music.stop()
	$Music2.stop()
	$Whaleloop.stop()
	$Spin.play()
	$BounceSound.set_volume_db(21)

func _on_HUD_bounce():
	$BounceSound.play()

func _on_HUD_purchase():
	$Purchase.play()

func _on_MiceChange_timeout():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if cursor_val == 1:
		Input.set_custom_mouse_cursor(arrow1)
		cursor_val = 2
	elif cursor_val == 2:
		Input.set_custom_mouse_cursor(arrow2)
		cursor_val = 3
	elif cursor_val == 3:
		Input.set_custom_mouse_cursor(arrow3)
		cursor_val = 4
	elif cursor_val == 4:
		Input.set_custom_mouse_cursor(arrow4)
		cursor_val = 1

func _process(delta):
	if Input.is_action_pressed("click"):
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND)
