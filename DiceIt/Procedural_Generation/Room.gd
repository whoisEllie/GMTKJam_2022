extends RigidBody2D


# Declare member variables here. Examples:
var size


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func make_room(_pos, _size):
	position = _pos
	size = _size  
	var s = RectangleShape2D.new()
	s.custom_solver_bias = 0.75
	s.extents = size
	$CollisionShape2D.shape = s


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
