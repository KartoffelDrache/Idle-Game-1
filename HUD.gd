extends CanvasLayer

signal paused
signal saving
signal loading
signal bounce
signal purchase
signal kill
signal coop_switch
signal coop_built
signal load_coop_built
var knives = 0.0
var blood = 0.0
var play = true
var spin = false
var coop_built = false
var count = 0.0
var count2 = 0.0
var count3 = 0.0
var spring_switch = true
var playdudes = true
var boing_ready = false
export(PackedScene) var knive_scene
export(PackedScene) var dude_scene
export(PackedScene) var star_scene


func _on_Purchase_pressed():
	knives += 1.0
	spawn_Knife()
	emit_signal("purchase")
	

func bleed():
	blood += knives*0.1	

func spawn_Knife():
	var knive_scene_new = knive_scene.instance()
	var knife_spawn_location = get_node("KnifePath/KnifePathPoint")
	knife_spawn_location.offset = randi()
	knive_scene_new.position = knife_spawn_location.position
	knive_scene_new.rotation += randf()*PI*2
	add_child(knive_scene_new)

func _process(_delta):
	if visible:
		play = true
	else:
		play = false
	if(play):
		$KnivesCount.text = str(knives)
		bleed()
		$BloodCount.text = str(blood)
		spring_move()
		if spin:
			count  = randf()
			count2 = randf()
			count3 = randf()
			$Background.modulate = Color(count,count2,count3) 

func _on_Pause_pressed():
	emit_signal("paused")


func _on_Main_saving():
	emit_signal("saving",knives,blood,coop_built)
	
func _on_PauseScreen_loading():
	emit_signal("loading")

func _on_Main_loaded(loadknives,loadblood,loadcoop,volume_start):
	knives = loadknives
	blood = loadblood
	coop_built = loadcoop
	if coop_built:
		$Coop.show()
		$Coop.animation = "built"
		emit_signal("load_coop_built")

func _ready():
	randomize()
	$SpawnTimer.start()
	$Background.modulate = Color(.4,0,0)
	$SpringSwitch.start()
	

func _on_SpawnTimer_timeout():
	if playdudes:
		var dude = dude_scene.instance()
		var dude_spawn_location = get_node("DudePath/DudePathLocation")
		dude_spawn_location.offset = randi()
		dude.position = dude_spawn_location.position
		add_child(dude)
	boing_ready = true

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
	if play and boing_ready:
		emit_signal("bounce")

func _on_KillButton_pressed():
	if blood > 5000:
		blood -= 5000
		$BloodCount.text = str(blood)
		get_tree().call_group("entities", "queue_free")
		sprinkle()
		sprinkle()
		sprinkle()
		sprinkle()
		$KillSound.play()
		$PKStarStorm.show()
		$PKStarStorm.frame = 0
		$PKStarStorm.play()
		playdudes = false
		$KillTimer.start()
		emit_signal("kill")
	else:
		$NoBlood.play()

func _on_KillTimer_timeout():
	playdudes = true
	$PKStarStorm.hide()
	$PKStarStorm.stop()

func sprinkle():
	var star = star_scene.instance()
	var star_spawn_location = get_node("StarPath/StarPathLocation")
	star_spawn_location.offset = randi()
	var direction = star_spawn_location.rotation +PI/2
	star.position = star_spawn_location.position
	var velocity = Vector2(rand_range(200.0,450.0), 0.0)
	star.linear_velocity = velocity.rotated(direction)
	add_child(star)
	
func _on_PauseScreen_adv_features():
	$Coop.show()
	$BuildCoop.show()
	$CoopBuildCost.show()

func _on_BuildCoop_pressed():
	if blood > 10000:
		blood -= 10000
		$BuildingCoop.show()
		$BuildCoop.hide()
		$Coop.animation = "building"
		$BuildTimer.start()
		$BuildingNoises.play()
	else:
		$NoBlood.play()

func _on_BuildTimer_timeout():
	$BuildingCoop.hide()
	$CoopBuildCost.hide()
	$Coop.animation = "built"
	coop_built = true
	emit_signal("coop_built")

func _on_Coop_coop_switch():
	if coop_built:
		emit_signal("coop_switch")
