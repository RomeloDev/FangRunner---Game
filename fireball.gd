extends Area2D # Changed from Node2D to Area2D for collision support

var speed = 300
var direction = Vector2.RIGHT

func _ready():
	$AnimatedSprite2D.play("fly")
	
	# Connect the "body_entered" signal via code
	# This detects when the fireball touches the Player or Walls
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	# Hit the Player
	if body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(1)
		queue_free() # Destroy the fireball
	
	# Hit a Wall or Floor (TileMap)
	# This prevents fireballs from flying through walls forever
	elif body is TileMap or body is StaticBody2D:
		queue_free()
