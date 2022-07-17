extends Node2D

var target_tile = 0
var target_position = Vector2(80.0, ProjectSettings.get_setting("display/window/size/height")/2)
var duration = 0.5 # length of the interpolation
var rng = RandomNumberGenerator.new()

signal level_changed(level_name)

export (String) var level_name = "level"


func generate_tiles():
	$Area2D.generate_tiles()
	$Area2D.load_tiles()
	
func load_tiles():
	$Area2D.load_tiles()
	print("tile set vars:")
	if range(vars.tile_set.size()).has(vars.current_tile):
		print(vars.tile_set)
		$BoardGamePlayer.transform = vars.tile_set[vars.current_tile].get_transform()
	target_tile = vars.current_tile
	target_position = vars.tile_set[vars.current_tile].position
	
	target_tile = target_tile + roll_dice(vars.collected_dice)
	vars.collected_dice = 0
	move_forward_one()

func _input(event):
	# only for debug!!!
	if event.is_action_pressed("ui_accept"):
		target_tile = target_tile + roll_dice(1)
		move_forward_one()

func move_forward_one():
	if vars.current_tile < target_tile:
		print(vars.tile_set)
		if range(vars.tile_set.size()).has(vars.current_tile+1):
			target_position = vars.tile_set[vars.current_tile+1].position
			vars.current_tile += 1
			$Timer.connect("timeout", self, "move_forward_one")
			$Timer.set_wait_time(duration)
			$Timer.start()
		else:
			print("finished")
	else:
		print("changing scene")
		change_scene()


func roll_dice(amount):
	rng.randomize()
	var spaces_to_move = 0
	for i in range (amount):
		var add = rng.randi_range(1, 6)
		spaces_to_move += add
		print(String(add))
	print("Added random " + String(spaces_to_move))
	return spaces_to_move

func _physics_process(delta):
	$BoardGamePlayer.position = $BoardGamePlayer.position.linear_interpolate(target_position, 0.2)


func change_scene():
	emit_signal("level_changed", level_name)
