extends Area2D

const TILE_AMOUNT = 100
const OFFSET = 160
const START_OFFSET = 80
const TILE_SIZE = 70
# Declare member variables here. Examples:
var tileIDs = []
var tiles = []

var objects_dict = {0: "Grass", 1: "Snow", 2: "Random"}
var grass_texture
var snow_texture
var randomblock_texture
var finish_texture
var start_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	# generates random array of tiles for the playing board
	var start_sprite = Sprite.new()
	add_child(start_sprite)
	start_texture = preload("res://Assets/Start-Block.png")
	start_sprite.set_texture(start_texture)
	start_sprite.set_scale(Vector2(1, 1))
	start_sprite.position = Vector2(START_OFFSET, ProjectSettings.get_setting("display/window/size/height")/2)
	
	
	
	for i in range (TILE_AMOUNT):
		tileIDs.append(randi() % 3)
		print(objects_dict[tileIDs[i]])
		if tileIDs[i] == 0:	
			var grass_sprite = Sprite.new()
			add_child(grass_sprite)
			grass_texture = preload("res://Assets/grass.png")
			grass_sprite.set_texture(grass_texture)
			grass_sprite.set_scale(Vector2(1, 1))
			grass_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(grass_sprite)
			
			
		if tileIDs[i] == 1:		
			var snow_sprite = Sprite.new()
			add_child(snow_sprite)
			snow_texture = preload("res://Assets/snow.png")
			snow_sprite.set_texture(snow_texture)
			snow_sprite.set_scale(Vector2(1, 1))
			snow_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(snow_sprite)

		if tileIDs[i] == 2:			
			var randomblock_sprite = Sprite.new()
			add_child(randomblock_sprite)
			randomblock_texture = preload("res://Assets/Random-Block.png")
			randomblock_sprite.set_texture(randomblock_texture)
			randomblock_sprite.set_scale(Vector2(1, 1))
			randomblock_sprite.position = Vector2(START_OFFSET + (OFFSET * tiles.size()), ProjectSettings.get_setting("display/window/size/height")/2)
			tiles.append(randomblock_sprite)
	
	print(tiles)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
