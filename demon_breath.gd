extends Area2D

func _ready():
	$AnimatedSprite2D.play("Breath")

func _on_animated_sprite_2d_animation_finished():
	queue_free() # Delete fire after animation ends

func _on_body_entered(body):
	# Check if the object we hit is the Player
	if body.name == "Player":
		# Check if the player has a health function
		if body.has_method("take_damage"):
			body.take_damage(1)
		
		# OPTIONAL: If your player doesn't have a function and just has a variable:
		# if "hp" in body:
		#     body.hp -= 1
