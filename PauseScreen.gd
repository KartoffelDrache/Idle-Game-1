extends CanvasLayer

signal resume
signal save
signal saving
signal loading
signal volume
signal musicChange
signal spin
signal adv_features
signal tint
var coop_built = false

func _on_Resume_pressed():
	emit_signal("resume")

func _on_Save_pressed():
	emit_signal("save")

func _on_Load_pressed():
	emit_signal("loading")
	emit_signal("resume")

func _on_Quit_pressed():
	get_tree().quit()


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


func _on_Main_loaded(loadknives,loadblood,loadcoop,volume_start):
	$VolumeSlider.value = volume_start
	
