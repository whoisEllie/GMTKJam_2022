extends Node2D

var target_tile = 0
var current_tile = 0
var target_position = Vector2(80.0, ProjectSettings.get_setting("display/window/size/height")/2)
var duration = 0.5 # length of the interpolation

signal level_changed(level_name)

export (String) var level_name = "level"



# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), "idle_frame")
	$BoardGamePlayer.transform = $Area2D.tiles[0].get_transform()
#	target_tile = roll_dice(1)
#	move_forward_one()

func _input(event):
	# only for debug!!!
	if event.is_action_pressed("ui_accept"):
		target_tile = target_tile + roll_dice(3)
		move_forward_one()
		
func move_forward_one():
	if current_tile < target_tile:
		if range($Area2D.tiles.size()).has(current_tile+1):
			target_position = $Area2D.tiles[current_tile+1].position
			current_tile += 1
			$Timer.connect("timeout", self, "move_forward_one")
			$Timer.set_wait_time(duration)
			$Timer.start()
		else:
			print("finished")
	else:
		print("changing scene")
		change_scene()


func roll_dice(amount):
	var spaces_to_move = 0
	for i in range (amount):
		var add = int(rand_range(1, 7))
		spaces_to_move += add
		print(String(add))
	print("Added random " + String(spaces_to_move))
	return spaces_to_move

func _physics_process(delta):
	$BoardGamePlayer.position = $BoardGamePlayer.position.linear_interpolate(target_position, 0.2)


func change_scene():
	emit_signal("level_changed", level_name)
