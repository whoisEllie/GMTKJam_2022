extends Area2D

const TILE_AMOUNT = 100
const OFFSET = 160
const START_OFFSET = 80
const TILE_SCALE = 2.3
var tiles = []

var rng = RandomNumberGenerator.new()

var objects_dict = {0: "Grass", 1: "Snow", 2: "Random"}
var grass_texture = preload("res://Assets/grass.png")
var snow_texture = preload("res://Assets/snow.png")
var randomblock_texture = preload("res://Assets/Random-Block.png")
var finalmblock_texture = preload("res://Assets/Finish-Block.png")
var start_texture = preload("res://Assets/Start-Block.png")

	
# Called when the node enters the scene tree for the first time.
func generate_tiles():
	for i in range (TILE_AMOUNT):
		rng.randomize()
		vars.tile_ids.append(rng.randi_range(0,2))
		
func load_tiles():
	tiles.clear()
	
	# generates random array of tiles for the playing board
	var start_sprite = Sprite.new()
	add_child(start_sprite)
	start_sprite.set_texture(start_texture)
	start_sprite.set_scale(Vector2(TILE_SCALE, TILE_SCALE))
	start_sprite.position = Vector2(START_OFFSET, ProjectSettings.get_setting("display/window/size/height")/2)
	tiles.append(start_sprite)
	
	for i in range(vars.tile_ids.size()):
		if vars.tile_ids[i] == 0:	
			var grass_sprite = Sprite.new()
			add_child(grass_sprite)
			grass_sprite.set_texture(grass_texture)
			grass_sprite.set_scale(Vector2(TILE_SCALE, TILE_SCALE))
			grass_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(grass_sprite)
			
		if vars.tile_ids[i] == 1:	
			var snow_sprite = Sprite.new()
			add_child(snow_sprite)
			snow_sprite.set_texture(snow_texture)
			snow_sprite.set_scale(Vector2(TILE_SCALE, TILE_SCALE))
			snow_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(snow_sprite)

		if vars.tile_ids[i] == 2:	
			var randomblock_sprite = Sprite.new()
			add_child(randomblock_sprite)
			randomblock_sprite.set_texture(randomblock_texture)
			randomblock_sprite.set_scale(Vector2(TILE_SCALE, TILE_SCALE))
			randomblock_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(randomblock_sprite)
			
	var finalblock_sprite = Sprite.new()
	add_child(finalblock_sprite)
	finalblock_sprite.set_texture(finalmblock_texture)
	finalblock_sprite.set_scale(Vector2(TILE_SCALE, TILE_SCALE))
	finalblock_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
	tiles.append(finalblock_sprite)
	
	vars.tile_set.clear()
	vars.tile_set = tiles
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
