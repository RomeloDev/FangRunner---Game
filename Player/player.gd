extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -470.0
const FALL_THRESHOLD := 1000.0

@onready var anim = get_node("AnimationPlayer")
@onready var jump_sound = $JumpSound
@onready var hurt_sound = $HurtSound

# --- NEW ADDITION ---
# Get a reference to the PausedUI node in your main scene.
# IMPORTANT: You might need to adjust this path based on where you put the UI!
# If it's in a CanvasLayer, the path might be "../CanvasLayer/PausedUI"
@onready var pause_menu = get_node("../PausedUI") 
# --------------------

func _input(event: InputEvent) -> void:
	# Check if the player pressed ESC (mapped to "ui_cancel" by default)
	if event.is_action_pressed("ui_cancel"):
		# Call the toggle function on the pause menu script
		if pause_menu:
			print("Paused Menu Pressed")
			pause_menu.toggle_pause()
			
			
func _ready() -> void:
	Game.playerHP = 10

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		jump_sound.pitch_scale = randf_range(0.8, 1.2)
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
			
	if velocity.y > 0:
		anim.play("Fall")	
		
	if !is_on_floor():
		if velocity.y > FALL_THRESHOLD:
			anim.play("Explode")
			print("Bro Fell Off")
			print("Game Over")
			queue_free()
			get_tree().change_scene_to_file("res://GameOver.tscn")
		
	move_and_slide()
	
	if Game.playerHP <= 0:
		anim.play("Explode")
		print("Game Over")
		
		# RESET HP HERE before going back to menu or restarting
		Game.playerHP = 10
		
		queue_free()
		get_tree().change_scene_to_file("res://GameOver.tscn")

func take_damage(amount):
	Game.playerHP -= amount
	print("Ouch! HP is now: ", Game.playerHP)
	hurt_sound.pitch_scale = randf_range(0.8, 1.2)
	hurt_sound.play()
	if Game.playerHP <= 0:
		print("Player Died!")
		queue_free()
		get_tree().change_scene_to_file("res://GameOver.tscn")
