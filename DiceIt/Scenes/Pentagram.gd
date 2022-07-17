extends Area2D

var rng = RandomNumberGenerator.new()
var added_upgrade = false

var timer = Timer.new()

var thunder = preload("res://Audio/BRS_Thunder_Clap_Big_No_Rain.wav")

func _ready():
	timer.connect("timeout", self, "change_scene")
	timer.wait_time = 5.0
	timer.one_shot = true;
	add_child(timer)
	$AudioStreamPlayer2D.stream = thunder
	$CanvasLayer/Control/RichTextLabel.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_upgrade():
	rng.randomize()
	match rng.randi_range(0, 8):
		1:
			vars.movement_speed += 50
			print("added move speed")
			$CanvasLayer/Control/RichTextLabel.text = "The wind whistles, you can feel yourself getting faster"
		2:
			vars.friction += 0.1
			print("added friction")
			$CanvasLayer/Control/RichTextLabel.text = "The soles of your boots strenghten, you slide around less"
		3:
			vars.acceleration += 0.1
			print("added acceleration")
			$CanvasLayer/Control/RichTextLabel.text = "Your souls spring up, you speed up faster"
		4:
			vars.bullet_speed += 100
			print("added bullet speed")
			$CanvasLayer/Control/RichTextLabel.text = "Your magazine reforms itself as your bullets become faster."
		5:
			vars.bullet_amount += 1
			print("added bullet amount")
			$CanvasLayer/Control/RichTextLabel.text = "Your weapon clicks as another barrel slides into place"
		6:
			vars.bullet_spread /= 1.1
			print("divided bullet spread")
			$CanvasLayer/Control/RichTextLabel.text = "Your weapon lengthens, bullets are more accurate."
		7:
			vars.shot_delay /= 1.1
			print("divided shot delay")
			$CanvasLayer/Control/RichTextLabel.text = "The hammer of your weapon shines in the sun as it's actions become faster"
		8:
			vars.bullet_damage += 2
			print("added bullet damage")
			$CanvasLayer/Control/RichTextLabel.text = "Your bullets glow as they strengthen, now doing more damage."

	vars.enemy_amount += 5
	timer.start()

func _on_Pentagram_area_entered(area):
	if area.name == "EyesArea" && !added_upgrade:
		$AudioStreamPlayer2D.play()
		print("player")
		add_upgrade()
		added_upgrade = true

func change_scene():
	get_owner().change_scene()
		
		
