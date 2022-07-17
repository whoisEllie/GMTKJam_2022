extends Area2D

func _physics_process(delta):
	position += transform.x * vars.bullet_speed * delta
