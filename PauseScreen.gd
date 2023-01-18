extends CanvasLayer

signal resume
signal save
signal loading
signal volume
signal musicChange
signal spin
signal adv_features
signal tint
signal quiting
signal open_shop
signal blood_count
signal blood_low
signal foxish_learned
signal credits
var coop_built = false


func _on_Resume_pressed():
	emit_signal("resume")

func _on_Save_pressed():
	emit_signal("save")

func _on_Load_pressed():
	emit_signal("loading")
	emit_signal("resume")

func _on_Quit_pressed():
	emit_signal("quiting")
	$QuitTimer.start()


func _on_Button_pressed():
	emit_signal("spin")
	
func _on_VolumeSlider_value_changed(volume):
	#if volume != 0:
	#	volume = volume/100
	emit_signal("volume",volume)

func _on_MusicChange_pressed():
	emit_signal("musicChange")

func _on_DynamicLights_pressed():
	emit_signal("tint")

func _on_HUD_kill():
	$AdvancedFeatures.show()

func _on_AdvancedFeatures_pressed():
	if !coop_built:
		emit_signal("adv_features")

func _on_HUD_coop_built():
	$CatWizard.show()

func _on_Main_saving():
	pass # Replace with function body.

func _on_HUD_load_coop_built():
	$AdvancedFeatures.show()
	$CatWizard.show()
	coop_built = true
	
func _on_Main_loaded(_lodknives,_loadblood,_loadcoop,volume_start):
	$VolumeSlider.value = volume_start
	
func _on_QuitTimer_timeout():
	get_tree().quit()

func _on_CoopZone_TwalesTalked():
	emit_signal("open_shop")

func _on_HUD_blood_count(blood):
	emit_signal("blood_count",blood)

func _on_CatWizard_blood_low():
	emit_signal("blood_low")

func _on_CatWizard_foxish_learned():
	emit_signal("foxish_learned")

func _on_Credits_pressed():
	emit_signal("credits")
