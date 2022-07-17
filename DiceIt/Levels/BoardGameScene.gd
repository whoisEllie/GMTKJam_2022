extends Node2D

var target_tile = 0
var target_position = Vector2(80.0, ProjectSettings.get_setting("display/window/size/height")/2)
var duration = 0.5 # length of the interpolation
var rng = RandomNumberGenerator.new()

var dice_roll_sfx = preload("res://Audio/FF_IG_foley_dice_roll_light.wav")
var celebration = preload("res://Audio/Bpm120_D_Celebration.wav")

var timer = Timer.new()

signal level_changed(level_name)

export (String) var level_name = "level"

func _ready():
	$AudioStreamPlayer2D.stream = dice_roll_sfx
	
	timer.connect("timeout", self, "move_forward_timer")
	timer.wait_time = 3.0
	timer.one_shot = true;
	add_child(timer)
	

func generate_tiles():
	$Area2D.generate_tiles()
	$Area2D.load_tiles()
	
func load_tiles():
	$Area2D.load_tiles()
	if range(vars.tile_set.size()).has(vars.current_tile):
		$BoardGamePlayer.transform = vars.tile_set[vars.current_tile].get_transform()
	if vars.move_back:
		if (vars.current_tile - 1) > 1:
			target_tile = vars.current_tile
			target_position = vars.tile_set[vars.current_tile].position
			target_tile =- 1
			change_scene()
		else:
			change_scene()
	else:
		target_tile = vars.current_tile
		target_position = vars.tile_set[vars.current_tile].position
		if vars.collected_dice == 0:
			target_tile += 1
		else:
			target_tile = target_tile + roll_dice()
		vars.collected_dice = 0
		
		timer.start()
		
func move_forward_timer():
	move_forward_one()

func _input(event):
	pass
	# only for debug!!!
#	if event.is_action_pressed("ui_accept"):
#		target_tile = target_tile + roll_dice(1)
#		move_forward_one()

func move_forward_one():
	if vars.current_tile < target_tile:
		if range(vars.tile_set.size()).has(vars.current_tile+1):
			target_position = vars.tile_set[vars.current_tile+1].position
			vars.current_tile += 1
			$Timer.connect("timeout", self, "move_forward_one")
			$Timer.set_wait_time(duration)
			$Timer.start()
		else:
			print("finished")
			$CanvasLayer/Control/RichTextLabel.text = ("Congratulations! You finished in " + vars.round_count + " rounds! Thanks for playing ^^")
			$AudioStreamPlayer2D.stream = celebration
			$AudioStreamPlayer2D.play()
	elif vars.move_back:
		vars.move_back = false
		vars.current_tile -= 1
		change_scene()
	else:
		change_scene()


func roll_dice():
	rng.randomize()
	var spaces_to_move = 0
	for i in range (vars.collected_dice):
		var add = rng.randi_range(1, 6)
		spaces_to_move += add
		print(String(add))
	print("Added random " + String(spaces_to_move))
	$CanvasLayer/Control/RichTextLabel.text = ("You rolled a " + String(spaces_to_move) + " with " + String(vars.collected_dice) + " dice.")
	return spaces_to_move

func _physics_process(delta):
	$BoardGamePlayer.position = $BoardGamePlayer.position.linear_interpolate(target_position, 0.2)


func change_scene():
	emit_signal("level_changed", level_name)
