extends Node


const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"Gem": Game.Gem,
		"current_scene_path":  Game.current_scene_path,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	if not FileAccess.file_exists(SAVE_PATH):
		return # Stop if no save file exists
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file.eof_reached():
		var current_line = JSON.parse_string(file.get_line())
		if current_line:
			Game.playerHP = current_line["playerHP"]
			Game.Gem = current_line["Gem"]
			# Load the path, with a fallback to Level 1 if it's missing
			if "current_scene_path" in current_line:
				Game.current_scene_path = current_line["current_scene_path"]
	#if FileAccess.file_exists(SAVE_PATH) == true:
		#if not file.eof_reached():
			#var current_line = JSON.parse_string(file.get_line())
			#if current_line:
				#Game.playerHP = current_line["playerHP"]
				#Game.Gem = current_line["Gem"]
