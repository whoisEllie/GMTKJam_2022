extends KinematicBody2D

onready var raycast =[$Trace1, $Trace2, $Trace3, $Trace4, $Trace5]
var ShotgunSound = preload("res://Audio/ESM_Designed_Game_Futuristic_Gun_Shot_154_Laser_Gun_Military_Pistol_Shot_Machine_Rifle_Sci_Fi_Mechanism_Alien_Space.wav")
export (PackedScene) var bullet
var ShotgunDamage = 10.0
var velocity = Vector2()
	
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
	
	
func get_input():
	var input = Vector2()
	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	return input
	

func _physics_process(delta):
	
	# movement
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * vars.movement_speed, vars.acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, vars.friction)
	velocity = move_and_slide(velocity)
	
	# weapon rotation
	var look_vec = get_global_mouse_position() - global_position
	$GunArc.rotation = atan2(look_vec.y, look_vec.x)

	# updating time
	$CanvasLayer/Control/RichTextLabel.text = String(timer.time_left)

func kill():
	# Needs implementation, return to global scene
	print("dead")
	
func shoot():
	var b = bullet.instance()
	get_parent().add_child(b)
	var bullet_transform = $GunArc/Sprite/BulletSpawnPoint.global_transform
	b.transform = Transform2D(bullet_transform.get_rotation() + (10.0 * (PI/180)), bullet_transform.get_origin())
	
func _input(event):
	# shooting
	if Input.is_action_just_pressed("shoot"):
		if $AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D.play()
		shoot()
