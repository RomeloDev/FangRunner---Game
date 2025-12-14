extends CharacterBody2D

var breath_scene = preload("res://DemonBreath.tscn")
var has_fired = false
var player_in_range = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func start_attack():
	has_fired = false
	$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "attack":
		if $AnimatedSprite2D.frame == 6 and has_fired == false:
			spawn_breath()
			has_fired = true

func spawn_breath():
	var breath = breath_scene.instantiate()
	add_child(breath)
	breath.position = Vector2(-85, 60)

	if $AnimatedSprite2D.flip_h:
		breath.position.x = -40
		breath.scale.x = -1

# 🔥 KEY FIX → loop attack animation as long as player is detected
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		if player_in_range:
			start_attack() # Attack AGAIN
		else:
			$AnimatedSprite2D.play("idle")

# Player enters detection zone
func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		start_attack()

# Player leaves detection zone
func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
