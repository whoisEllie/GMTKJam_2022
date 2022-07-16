extends Area2D

const TILE_AMOUNT = 10
const OFFSET = 160
const START_OFFSET = 80
const TILE_SIZE = 70
# Declare member variables here. Examples:
var tiles = []
var objects_dict = {0: "Grass", 1: "Snow"}
var grass_texture
var snow_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	# generates random array of tiles for the playing board
	for i in range (TILE_AMOUNT):
		tiles.append(randi() % 2)
		print(objects_dict[tiles[i]])
		if tiles[i] == 0:
			var grass_block = RectangleShape2D.new()
			grass_block.set_extents(Vector2(TILE_SIZE, TILE_SIZE))
			var collision = CollisionShape2D.new()
			collision.set_shape(grass_block)
			collision.position = Vector2(START_OFFSET + (OFFSET * i), ProjectSettings.get_setting("display/window/size/height")/2)
			print(String(OFFSET * i))
			add_child(collision)
			
			var grass_sprite = Sprite.new()
			add_child(grass_sprite)
			grass_texture = preload("res://Assets/grass.png")
			grass_sprite.set_texture(grass_texture)
			grass_sprite.position = Vector2(START_OFFSET + (OFFSET * i), ProjectSettings.get_setting("display/window/size/height")/2)
			
			
		if tiles[i] == 1:
			var snow_block = RectangleShape2D.new()
			snow_block.set_extents(Vector2(TILE_SIZE, TILE_SIZE))
			var collision = CollisionShape2D.new()
			collision.set_shape(snow_block)
			collision.position = Vector2(START_OFFSET + (OFFSET * i), ProjectSettings.get_setting("display/window/size/height")/2)
			print(String(OFFSET * i))
			add_child(collision)
			
			var snow_sprite = Sprite.new()
			add_child(snow_sprite)
			snow_texture = preload("res://Assets/snow.png")
			snow_sprite.set_texture(snow_texture)
			snow_sprite.position = Vector2(START_OFFSET + (OFFSET * i), ProjectSettings.get_setting("display/window/size/height")/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
