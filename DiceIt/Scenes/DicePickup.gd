extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_DicePickup_body_entered(body):
	print("YES")
	if body.name == "Player":
		vars.collected_dice += 1
		queue_free()
	
