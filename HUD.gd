extends CanvasLayer

signal paused
signal saving
signal loading
signal bounce
signal purchase
var knives = 0.0
var blood = 0.0
var play = true
var spin = false
var count = 0.0
var count2 = 0.0
var count3 = 0.0
var spring_switch = true
export(PackedScene) var knive_scene
export(PackedScene) var dude_scene


func _on_Purchase_pressed():
	knives += 1.0
	spawn_Knife()
	emit_signal("purchase")

func bleed(knives):
	blood += knives*0.1	

func spawn_Knife():
	var knive_scene_new = knive_scene.instance()
	var knife_spawn_location = get_node("KnifePath/KnifePathPoint")
	knife_spawn_location.offset = randi()
	knive_scene_new.position = knife_spawn_location.position
	knive_scene_new.rotation += randf()*PI*2
	add_child(knive_scene_new)

func _process(_delta):
	if(play):
		$KnivesCount.text = str(knives)
		bleed(knives)
		$BloodCount.text = str(blood)
		spring_move()
		if spin:
			count  = randf()
			count2 = randf()
			count3 = randf()
			$Background.modulate = Color(count,count2,count3) 


func _on_Pause_pressed():
	emit_signal("paused")

func _on_HUD_visibility_changed(): 
	if(play == true):
		play = false
	else:
		play = true

func _on_Main_saving():
	emit_signal("saving",knives,blood)

func _on_PauseScreen_loading():
	emit_signal("loading")

func _on_Main_loaded(loadknives,loadblood):
	knives = loadknives
	blood = loadblood

func _ready():
	randomize()
	$SpawnTimer.start()
	$Background.modulate = Color(.4,0,0)
	$SpringSwitch.start()

func _on_SpawnTimer_timeout():
	var dude = dude_scene.instance()
	var dude_spawn_location = get_node("DudePath/DudePathLocation")
	dude_spawn_location.offset = randi()
	dude.position = dude_spawn_location.position
	add_child(dude)

func _on_PauseScreen_spin():
	spin = true

func spring_move():
	if spring_switch:
		$Spring.move_and_slide(Vector2(300,0))
	elif !spring_switch:
		$Spring.move_and_slide(Vector2(-300,0))

func _on_SpringSwitch_timeout():
	if spring_switch:
		spring_switch = false
	else:
		spring_switch = true

func _on_Spring_bounce():
	if play:
		emit_signal("bounce")



"""
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()	

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

"""







