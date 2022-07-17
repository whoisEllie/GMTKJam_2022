extends Area2D

func _physics_process(delta):
	position += transform.x * vars.bullet_speed * delta



func _on_Area2D_body_entered(body):
	print("Bullet time!")
	if body.has_method("take_damage"):
		body.take_damage()
