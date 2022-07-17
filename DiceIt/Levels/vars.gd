extends Node


# Declare member variables here. Examples:
var current_tile: int = 0
var collected_dice: int = 0
var tile_ids = []
var tile_set = []
var round_time = 20.0

# player modifier variables
var movement_speed = 200
var friction = 0.3
var acceleration = 0.3

# bullet movement modifiers
var bullet_speed = 400
var bullet_amount = 1
var bullet_spread = 15.0
var shot_delay = 0.2
var bullet_damage = 10.0
