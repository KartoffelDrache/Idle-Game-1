extends Node

#func _ready():
#func _process(delta):
var file_data
signal saving
signal loaded

func _ready():
	$Music.play()


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
	file.open("G:/Godot Downloads/Idle Game 1/data.json", File.WRITE)
	file.store_line(to_json(file_data))
	file.close()
	
func loading():
	var file = File.new()
	file.open("G:/Godot Downloads/Idle Game 1/data.json",File.READ)
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
