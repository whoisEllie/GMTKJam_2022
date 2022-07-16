extends KinematicBody2D

const MOVE_SPEED = 100
onready var raycast =[$Trace1, $Trace2, $Trace3, $Trace4, $Trace5]
var ShotgunSound = preload("res://Audio/12-Gauge-Pump-Action-Shotgun-Close-Gunshot-A-www.fesliyanstudios.com.mp3")
var ShotgunDamage = 10.0

var timer = Timer.new()

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	$AudioStreamPlayer2D.stream = ShotgunSound
	
	timer.connect("timeout", self, "timeout")
	timer.wait_time = vars.round_time
	timer.one_shot = true;
	add_child(timer)
	timer.start()
	
func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	# shooting
	if Input.is_action_just_pressed("shoot"):
		if $AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D.play()
		for ray in raycast:
			var hit_collider = ray.get_collider()
			if ray.is_colliding() and hit_collider.has_method("take_damage"):
				hit_collider.take_damage(ShotgunDamage)
				
	# updating time
	$CanvasLayer/Control/RichTextLabel.text = String(timer.time_left)
	
	# coin picku

func kill():
	# Needs implementation, return to global scene
	print("dead")
