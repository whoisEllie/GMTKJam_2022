extends Node2D


var Room = preload("res://Procedural_Generation/Room.tscn")

var tile_size = 32
var num_rooms = 50
var min_size = 4
var max_size = 10
var hspread = 40
var vspread = 100
var cull_percent = 0.35

func _ready():
	randomize()
	make_rooms()
	
func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-hspread, hspread), rand_range(-vspread, vspread))
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	# wait for rooms to stop moving
	yield(get_tree().create_timer(1.1), 'timeout')
	# cull rooms
	var cull_amount : int = int($Rooms.get_child_count()*cull_percent)
	for i in range(cull_amount):
		var room = $Rooms.get_child(randi() % ($Rooms.get_child_count()))
		room.queue_free()
	for room in $Rooms.get_children():
		room.mode = RigidBody2D.MODE_STATIC

func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),
		Color(32, 228, 0), false)
		
func _process(delta):
	update()

func _input(event):
	if event.is_action_pressed('ui_select'):
		for n in $Rooms.get_children():
			n.queue_free()
		make_rooms()
