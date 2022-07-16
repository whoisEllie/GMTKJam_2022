extends Area2D


const TILE_AMOUNT = 50
enum Types {GRASS, SNOW}
# Declare member variables here. Examples:
var tiles = []
var grass_block = RectangleShape2D.new()
var snow_block = RectangleShape2D.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# generates random array of tiles for the playing board
	for i in range (TILE_AMOUNT):
		tiles.append(Types.keys()[randi() % Types.size()])
	for i in range (tiles.size()):
		if tiles[i] == Types.GRASS:
			
		if tiles[i] == Types.SNOW:


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
