extends Node2D


func _on_try_again_pressed() -> void:
	# 1. Load the last save file
	# This restores the 'current_scene_path' and 'Gem' count from when you entered the level
	Utils.loadGame()
	
	# 2. Fully Heal the Player
	# We overwrite the saved HP because we don't want to restart with 1 HP
	Game.playerHP = 10
	
	# 3. Switch to the saved level
	if Game.current_scene_path != "":
		get_tree().change_scene_to_file(Game.current_scene_path)
	else:
		# Fallback: If no save exists, go to Level 1
		get_tree().change_scene_to_file("res://world.tscn")



func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
