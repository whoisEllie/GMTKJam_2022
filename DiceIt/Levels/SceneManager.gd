extends Node

var next_level = null

onready var current_level = $BoardGameLevel
onready var anim = $AnimationPlayer

var loadtiles = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level.generate_tiles()
	current_level.connect("level_changed", self, "handle_level_changed")
	vars.collected_dice = 1
	
	var timer = Timer.new()
	timer.connect("timeout", self, "roll_and_move")
	timer.wait_time = 5
	timer.one_shot = true;
	add_child(timer)
	timer.start()
	


func roll_and_move():
	current_level.target_tile = vars.current_tile
	current_level.target_position = vars.tile_set[vars.current_tile].position
	current_level.target_tile = current_level.target_tile + current_level.roll_dice()
	vars.collected_dice = 0
	current_level.move_forward_one()

func handle_level_changed(current_level_name: String):
	match current_level_name:
		"BoardGame":
			print(vars.tile_ids[vars.current_tile-1])
			match vars.tile_ids[vars.current_tile-1]:
				0:
					next_level = load("res://Levels/GrassTopDownScene.tscn").instance()
					loadtiles = false
					print("grass")
					vars.scene_type = 0
				1:
					next_level = load("res://Levels/SnowTopDownScene.tscn").instance()
					loadtiles = false
					print("snow")
					vars.scene_type = 1
				2:
					next_level = load("res://Levels/RandomScene.tscn").instance()
					loadtiles = false
					print("random effect")
					vars.scene_type = 2

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
