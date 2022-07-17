extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}

export (PackedScene) var bullet

onready var player_detection_zone = $PlayerDetectionZone

const MOVE_SPEED = 100

var bullet_destroy_sound = preload("res://Audio/FF_AF_foley_bullet_impact_green.wav")

var health = 100.0
var current_state: int = State.PATROL setget set_state
var player = null
var rng = RandomNumberGenerator.new()

var shoot_timer = Timer.new()

func _ready():
	shoot_timer.connect("timeout", self, "shoot")
	shoot_timer.one_shot = false;
	add_child(shoot_timer)
	$AudioStreamPlayer2D.stream = bullet_destroy_sound

func set_state(new_state: int):
	if new_state == current_state:
		return
	current_state = new_state
	emit_signal("state_changed", current_state)

func take_damage(damage):
	health -= damage
	if health <= 0.0:
		get_parent().queue_free()

func _process(delta):
	match current_state:
		State.PATROL:
			pass
			shoot_timer.stop()
		State.ENGAGE:
			if player != null:
				var vec_to_player = player.global_position - global_position
				vec_to_player = vec_to_player.normalized()
				global_rotation = atan2(vec_to_player.y, vec_to_player.x)
				get_parent().move_and_collide(vec_to_player * MOVE_SPEED * delta)
				if shoot_timer.time_left <= 0:
					shoot_timer.set_wait_time(0.4)
					shoot_timer.start()
		_:
			pass

func _on_Area2D_area_entered(area):
	take_damage(vars.bullet_damage)
	$AudioStreamPlayer2D.play()
	area.queue_free()


func _on_PlayerDetectionZone_body_entered(body):
	if body.is_in_group("Player"):
		set_state(State.ENGAGE)
		player = body
	
func shoot():
	for i in range(6):
		var b = bullet.instance()
		get_parent().add_child(b)
		var bullet_transform = self.transform
		rng.randomize()
		b.transform = Transform2D(bullet_transform.get_rotation() + (rng.randf_range(-180, 180) * (PI/180)), bullet_transform.get_origin())


func _on_PlayerDetectionZone_body_exited(body):
	if body.is_in_group("Player"):
		set_state(State.PATROL)
