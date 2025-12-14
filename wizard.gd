extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var fireball_spawn = $FireballSpawn

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const FIREBALL = preload("res://Fireball.tscn")

var player_in_range = false
var is_attacking = false
var player = null # We will store the actual Player node here

func _ready() -> void:
	sprite.play("Idle")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()

	# Only play Idle if we are NOT attacking
	if not is_attacking:
		sprite.play("Idle")

func _on_player_detection_body_entered(body: Node2D) -> void:
	# Matches your Skeleton script logic: Check by Name
	if body.name == "Player": 
		player_in_range = true
		player = body # <--- Capture the player node so we can aim at it later!
		attack()

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		player = null # Forget the player when they leave

func attack():
	# Stop if we are already attacking OR if the player walked away
	if is_attacking or not player_in_range:
		return
	
	is_attacking = true
	sprite.play("Fire")
	
	# 1. Wait 0.4 seconds (syncs with the animation frame where hand extends)
	await get_tree().create_timer(0.4).timeout
	
	# 2. Shoot the fireball (Only if player is still there)
	if player_in_range and player != null:
		shoot_fireball()
	
	# 3. Wait another 0.6 seconds (cooldown/animation finish)
	await get_tree().create_timer(0.6).timeout
	
	is_attacking = false
	
	# 4. If player is still there, attack again loop
	if player_in_range:
		attack()

func shoot_fireball():
	var fb = FIREBALL.instantiate()
	fb.global_position = fireball_spawn.global_position
	
	# Use the 'player' variable we captured in the body_entered function
	if player != null:
		# Calculate direction towards the player
		var direction = (player.global_position - fireball_spawn.global_position).normalized()
		fb.direction = direction
		
		# Flip wizard to face player
		if player.global_position.x < global_position.x:
			sprite.flip_h = false # Face Left
			fireball_spawn.position.x = -abs(fireball_spawn.position.x) # Move spawn point to left
		else:
			sprite.flip_h = true  # Face Right
			fireball_spawn.position.x = abs(fireball_spawn.position.x) # Move spawn point to right
			
	get_parent().add_child(fb)
