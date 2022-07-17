extends Node2D


var rng = RandomNumberGenerator.new()

signal level_changed(level_name)

export (String) var level_name = "level"

func _ready():
	pass


func change_scene():
	vars.collected_dice = 1
	emit_signal("level_changed", level_name)
