extends Node2D


func _ready() -> void:
	#Utils.saveGame()
	Utils.loadGame()

func _on_play_btn_pressed() -> void:
	# Reset data for a new game
	Game.playerHP = 10
	Game.Gem = 0
	Game.current_scene_path = "res://world.tscn"
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	# 1. Load the data from file into Game.gd
	Utils.loadGame()
	
	# 2. Check if the path is valid, then switch
	if Game.current_scene_path != "":
		get_tree().change_scene_to_file(Game.current_scene_path)
	else:
		# Fallback if save is empty
		get_tree().change_scene_to_file("res://world.tscn")


func _on_play_pressed() -> void:
	Game.playerHP = 10
	Game.Gem = 0
	Game.current_scene_path = "res://world.tscn"
	get_tree().change_scene_to_file("res://world.tscn")


func _on_button_pressed() -> void:
	# 1. Load the data from file into Game.gd
	Utils.loadGame()
	
	# 2. Check if the path is valid, then switch
	if Game.current_scene_path != "":
		get_tree().change_scene_to_file(Game.current_scene_path)
	else:
		# Fallback if save is empty
		get_tree().change_scene_to_file("res://world.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
