extends Area2D

var rng = RandomNumberGenerator.new()
var added_upgrade = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# player modifier variables
var movement_speed = 200
var friction = 0.3
var acceleration = 0.3

# bullet movement modifiers
var bullet_speed = 400
var bullet_amount = 1
var bullet_spread = 15.0
var shot_delay = 0.2
var bullet_damage = 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_upgrade():
	rng.randomize()
	match rng.randi_range(0, 8):
		1:
			vars.movement_speed += 50
			print("added move speed")
		2:
			vars.friction += 0.1
			print("added friction")
		3:
			vars.acceleration += 0.1
			print("added acceleration")
		4:
			vars.bullet_speed += 100
			print("added bullet speed")
		5:
			vars.bullet_amount += 1
			print("added bullet amount")
		6:
			vars.bullet_spread /= 1.1
			print("divided bullet spread")
		7:
			vars.shot_delay /= 1.1
			print("divided shot delay")
		8:
			vars.bullet_damage += 2
			print("added bullet damage")
			
	


func _on_Pentagram_area_entered(area):
	if area.name == "EyesArea" && !added_upgrade:
		print("player")
		add_upgrade()
		added_upgrade = true
		get_owner().change_scene()
		
		
