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
var click1 = load("res://SMILEYWINKEDIT1.png")
var click2 = load("res://SMILEYWINKEDIT2.png")
var click3 = load("res://SMILEYWINKEDIT3.png")
var click4 = load("res://SMILEYWINKEDIT4.png")
var count = 0
var count2 = 17
var count3 = 31
var yes = false
var tint = 0.1
var cooped = 0
var loadcoop = false
var volume_start
var disable_smile = false
var quiting = false
var stupid_dumb_timer_check = true


func _ready():
	$Music.play()
	$MiceChange.start()
	$MouseClickChangeTimer.start()
	$Background.modulate = Color(.5,0,0)
	$Tint.modulate = Color(1,1,1,.001) 
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_MOVE)
	$CoopZone/UI.hide()

func _on_HUD_paused():
	$HUD.hide()
	$PauseScreen.show()

func _on_PauseScreen_resume():
	$HUD.show()
	$PauseScreen.hide()

func _on_PauseScreen_save():
	emit_signal("saving")

func _on_HUD_saving(knives,blood,coop_built):
	save(knives,blood,coop_built)

func _on_HUD_loading():
	loading()

func save(knives,blood,coop_built):
	if coop_built:
		cooped = 1
	else:
		cooped = 0
	file_data = {"knives":knives,"blood":blood,"coop_built":cooped,"volume":volume_start}
	
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
	var rawcoop = file_data.coop_built
	volume_start = file_data.volume
	if rawcoop == 1:
		loadcoop = true
	else:
		loadcoop = false
	$Music.set_volume_db(volume_start)
	$Music2.set_volume_db(volume_start)
	$Whaleloop.set_volume_db(volume_start)
	emit_signal("loaded",loadknives,loadblood,loadcoop,volume_start)

func _on_PauseScreen_volume(volume):
	$Music.set_volume_db(volume)
	$Music2.set_volume_db(volume)
	$Whaleloop.set_volume_db(volume)
	volume_start = volume
	
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
	yes = true
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
	if !disable_smile:
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

func _process(_delta):
	if quiting:
		Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND)
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		disable_smile = true
	if Input.is_action_pressed("click"):
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		Input.set_custom_mouse_cursor(click1, Input.CURSOR_POINTING_HAND)
		clicking()
		stupid_dumb_timer_check = true
	else:
		stupid_dumb_timer_check = false
	if yes:
		count  = randf()
		count2 = randf()
		count3 = randf()
		$Background.modulate = Color(count,count2,count3)
		$Tint.modulate = Color(1,1,1,0.001) 

func _on_HUD_coop_switch():
	$CoopZone.show()
	$HUD.hide()
	$Background.hide()
	$Tint.hide()
	$CoopZone/UI.show()

func _on_PauseScreen_tint():
	$Tint.modulate = Color(0,0,0,tint) 
	tint += 0.05

func _on_CoopZone_return_HUD():
	$HUD.show()
	$Background.show()
	$Tint.show()
	$CoopZone.hide()
	$CoopZone/UI.hide()

func _on_SmileDisableTimer_timeout():
	disable_smile = false

func _on_PauseScreen_quiting():
	quiting = true

func clicking():
	disable_smile = true
	$SmileDisableTimer.start()

func _on_MouseClickChangeTimer_timeout():
	"""
		if stupid_dumb_timer_check:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			if cursor_val == 1:
				Input.set_custom_mouse_cursor(click1, Input.CURSOR_POINTING_HAND)
				cursor_val = 2
			elif cursor_val == 2:
				Input.set_custom_mouse_cursor(click2, Input.CURSOR_POINTING_HAND)
				cursor_val = 3
			elif cursor_val == 3:
				Input.set_custom_mouse_cursor(click3, Input.CURSOR_POINTING_HAND)
				cursor_val = 4
			elif cursor_val == 4:
				Input.set_custom_mouse_cursor(click4, Input.CURSOR_POINTING_HAND)
				cursor_val = 1
"""

	
