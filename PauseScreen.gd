extends CanvasLayer

signal resume
signal save
signal loading
signal volume
signal musicChange
signal spin
var count = 0
var count2 = 17
var count3 = 31
var yes = false
var tint = 0.1

func _on_Resume_pressed():
	emit_signal("resume")

func _on_Save_pressed():
	emit_signal("save")

func _on_Load_pressed():
	emit_signal("loading")
	emit_signal("resume")

func _on_Quit_pressed():
	get_tree().quit()

func _process(_delta):
	count  = randf()
	count2 = randf()
	count3 = randf()
	if yes:
		$ColorRect.modulate = Color(count,count2,count3) 

func _ready():
	$ColorRect.modulate = Color(.5,0,0)
	$Tint.modulate = Color(1,1,1,.001) 

func _on_Button_pressed():
	yes = true
	emit_signal("spin")
	

func _on_VolumeSlider_value_changed(volume):
	#if volume != 0:
	#	volume = volume/100
	emit_signal("volume",volume)

func _on_MusicChange_pressed():
	emit_signal("musicChange")


func _on_DynamicLights_pressed():
	$Tint.modulate = Color(0,0,0,tint) 
	tint += 0.05
