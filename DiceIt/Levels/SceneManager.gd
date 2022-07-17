extends Node

var next_level = null

onready var current_level = $BoardGameLevel
onready var anim = $AnimationPlayer

var loadtiles = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level.generate_tiles()
	current_level.connect("level_changed", self, "handle_level_changed")


func handle_level_changed(current_level_name: String):
	match current_level_name:
		"BoardGame":
			print(vars.tile_ids[vars.current_tile-1])
			match vars.tile_ids[vars.current_tile-1]:
				0:
					next_level = load("res://Levels/GrassTopDownScene.tscn").instance()
					loadtiles = false
					print("grass")
				1:
					next_level = load("res://Levels/SnowTopDownScene.tscn").instance()
					loadtiles = false
					print("snow")
				2:
					next_level = load("res://Levels/GrassTopDownScene.tscn").instance()
					loadtiles = false
					print("random effect")

		"TopDown":
			next_level = load("res://Levels/BoardGameScene.tscn").instance()
			loadtiles = true
		_:
			return
			loadtiles = false
	
	anim.play("fade_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			add_child(next_level)
			next_level.connect("level_changed", self, "handle_level_changed")
			current_level.queue_free()
			current_level = next_level
			next_level = null
			if loadtiles:
				current_level.load_tiles()
			anim.play("fade_out")
