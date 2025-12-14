extends Area2D

@export_file("*.tscn") var target_scene_path: String

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Portal hit by: ", body.name)
	if body.name == "Player" or body.is_in_group("player"):
		change_scene()

func change_scene():
	if target_scene_path == "":
		print("Error: No target scene set for this portal!")
		return
	
	# 1. Update the Global Variable
	Game.current_scene_path = target_scene_path
	
	# 2. Save the game immediately so 'Resume' works if they quit next
	Utils.saveGame()
	
	# 3. Change Scene
	call_deferred("_deferred_change_scene")

func _deferred_change_scene():
	get_tree().change_scene_to_file(target_scene_path)
