extends Node2D

var active_tile = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), "idle_frame")
	$BoardGamePlayer.transform = $Area2D.tiles[0].get_transform()
	roll_dice(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		active_tile = active_tile + 1
		if range($Area2D.tiles.size()).has(active_tile):
			$BoardGamePlayer.transform = $Area2D.tiles[active_tile].get_transform()
		else:
			print("finished")


func roll_dice(amount):
	var spaces_to_move = 0
	for i in range (amount):
		var add = int(rand_range(1, 7))
		spaces_to_move += add
		print(String(add))
	print("Added random " + String(spaces_to_move))
	return spaces_to_move
