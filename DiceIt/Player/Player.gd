extends KinematicBody2D

onready var raycast =[$Trace1, $Trace2, $Trace3, $Trace4, $Trace5]
var ShotgunSound = preload("res://Audio/ESM_Designed_Game_Futuristic_Gun_Shot_154_Laser_Gun_Military_Pistol_Shot_Machine_Rifle_Sci_Fi_Mechanism_Alien_Space.wav")
export (PackedScene) var bullet
var ShotgunDamage = 10.0
var velocity = Vector2()
var rng = RandomNumberGenerator.new()

var should_fire = true

var timer = Timer.new()
var shoot_timer = Timer.new()

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	$AudioStreamPlayer2D.stream = ShotgunSound
	
	timer.connect("timeout", self, "timeout")
	timer.wait_time = vars.round_time
	timer.one_shot = true;
	add_child(timer)
	timer.start()
	
	shoot_timer.connect("timeout", self, "shoot")
	shoot_timer.one_shot = false;
	add_child(shoot_timer)
	
	
	
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
	
	# updating time
	if vars.scene_type != 2:
		$CanvasLayer/Control/RichTextLabel.text = String(stepify(timer.time_left, 0.01))
	
	if $CollisionShape2D/Sprite.frame == 4:
		$CollisionShape2D/Sprite/EyesArea.translate(Vector2(0.0, -0.1))
	if $CollisionShape2D/Sprite.frame == 0:
		$CollisionShape2D/Sprite/EyesArea.translate(Vector2(0.0, 0.1))
		
func _process(delta):
	# weapon rotation
	var look_vec = get_global_mouse_position() - global_position
	$GunArc.rotation = atan2(look_vec.y, look_vec.x)
	$CollisionShape2D/Sprite/EyesArea/EyesArc.rotation = atan2(look_vec.y, look_vec.x)
	
	# shooting
	if Input.is_action_just_pressed("shoot"):
		shoot()
		shoot_timer.set_wait_time(vars.shot_delay)
		shoot_timer.start()
	if Input.is_action_just_released("shoot"):
		shoot_timer.stop()

func kill():
	# Needs implementation, return to global scene
	print("dead")
	
func shoot():
	$AudioStreamPlayer2D.play()
	for i in range(vars.bullet_amount):
		var b = bullet.instance()
		get_parent().add_child(b)
		var bullet_transform = $GunArc/Sprite/BulletSpawnPoint.global_transform
		rng.randomize()
		b.transform = Transform2D(bullet_transform.get_rotation() + (rng.randf_range(-vars.bullet_spread, vars.bullet_spread) * (PI/180)), bullet_transform.get_origin())
