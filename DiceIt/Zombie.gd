extends KinematicBody2D

const MOVE_SPEED = 15

onready var raycast = $RayCast2D

var player = null
var health = 100.0

func _ready():
	add_to_group("zombies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func take_damage(damage):
	health -= damage
	if health <= 0.0:
		queue_free()

func set_player(p):
	player = p
