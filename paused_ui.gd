extends Control

func _ready():
	# 1. Hide the pause menu immediately when the game starts
	hide()

# --- THIS IS THE MISSING PART ---
func _input(event):
	# Check if the player pressed ESC
	if event.is_action_pressed("ui_cancel"):
		print("Escape key pressed! Toggling pause...") # <--- ADD THIS LINE
		toggle_pause()

func toggle_pause():
	# Check current state: Is the game paused?
	var is_paused = get_tree().paused
	
	if is_paused:
		# If already paused -> Unpause and Hide Menu
		get_tree().paused = false
		hide()
	else:
		# If playing -> Pause and Show Menu
		get_tree().paused = true
		show()

# --- YOUR EXISTING BUTTON LOGIC ---

func _on_resume_pressed() -> void:
	# Use the helper function we just made so it handles everything
	toggle_pause()

func _on_main_menu_pressed() -> void:
	# CRITICAL FIX: Unpause before leaving!
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
