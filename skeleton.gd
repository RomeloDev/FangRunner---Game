extends CharacterBody2D

const SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_VELOCITY = -400.0
var player
var chase = false

@onready var death_sound = $DeathSound

func _ready():
	get_node("AnimatedSprite2D").play("Rise")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Chase")
			player = get_node("../../Player")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
			#print(str(player.global_position))
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Rise")
			velocity.x = 0

	move_and_slide()


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false

func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		velocity.x = 0
		death()


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(1)
		velocity.x = 0
		death()

func death():
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	death_sound.pitch_scale = randf_range(0.8, 1.2)
	death_sound.play()
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
