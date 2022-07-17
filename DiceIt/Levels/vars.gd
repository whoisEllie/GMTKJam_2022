extends Node


# Declare member variables here. Examples:
var current_tile: int = 0
var collected_dice: int = 0
var tile_ids = []
var tile_set = []
var round_time = 20.0

# player modifier variables
var movement_speed = 150
var friction = 0.3
var acceleration = 0.15
