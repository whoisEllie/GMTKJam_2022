extends Node2D

const DICE_AMOUNT = 3
const DicePickup = preload("res://Scenes/DicePickup.tscn")

var noise
var map_size = Vector2(50, 50)
var grass_cap = 0.5
var road_caps = Vector2(0.3, 0.05)
var environment_caps = Vector3(0.4, 0.3, 0.04)
var timer = Timer.new()
var rng = RandomNumberGenerator.new()

var dice = []

signal level_changed(level_name)

export (String) var level_name = "level"

func _ready():
	noise = OpenSimplexNoise.new()
	noise.octaves = 1.0
	noise.period = 12
	noise.seed = randi()
	make_grass_map()
	make_road_map()
	make_environment_map()
	make_background()
	fill_rest()
	spawn_dice()
	draw_rect(Rect2(Vector2(0,0), map_size*16), Color(255, 0, 0, 255), true, 16.0)

	timer.connect("timeout", self, "change_scene")
	timer.wait_time = vars.round_time
	timer.one_shot = true;
	add_child(timer)
	timer.start()
	
func make_grass_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < grass_cap:
				$Grass.set_cell(x, y, 0)
	$Grass.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))

func make_road_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < road_caps.x and a > road_caps.y:
				$Roads.set_cell(x, y, 0)
	$Roads.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))

func make_environment_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x, y)
			if a < environment_caps.x and a > environment_caps.y or a < environment_caps.z:
				var chance = randi() % 100
				if chance < 2:
					var num = randi() % 4
					$Environment.set_cell(x, y, num)

func make_background():
	for x in map_size.x:
		for y in map_size.y:
			if $Grass.get_cell(x,y) == -1:
				if $Grass.get_cell(x,y-1) == 0:
					$Background.set_cell(x,y,0)
					
	$Background.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))

func fill_rest():
	for x in map_size.x:
		for y in map_size.y:
			if $Grass.get_cell(x,y) != 0:
				$Collision.set_cell(x,y,0)
					
	$Collision.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	
func spawn_dice():
	for i in DICE_AMOUNT:
		var new_dice = DicePickup.instance()
		rng.randomize()
		new_dice.position = Vector2(rng.randf_range(0, map_size.x*16), rng.randf_range(0, map_size.y*16))
		dice.append(new_dice)
		add_child(new_dice)


func change_scene():
	emit_signal("level_changed", level_name)
