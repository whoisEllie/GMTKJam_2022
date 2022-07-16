extends Node

var next_level = null

onready var current_level = $BoardGameLevel
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level.connect("level_changed", self, "handle_level_changed")


func handle_level_changed(current_level_name: String):
	match current_level_name:
		"BoardGame":
			next_level = load("res://Levels/LevelScene.tscn").instance()
		"TopDown":
			next_level = load("res://Levels/BoardGameScene.tscn").instance()
		_:
			return
			
	#next_level.layer = -1
	anim.play("fade_in")	
	


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			add_child(next_level)
			next_level.connect("level_changed", self, "handle_level_changed")
			current_level.queue_free()
			current_level = next_level
			#current_level.layer = 1
			next_level = null
			anim.play("fade_out")
