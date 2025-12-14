extends Node

var playerHP = 10
var MAX_HP = 10  # Hard limit for health
var Gem = 0
var current_scene_path = "res://world.tscn"

# Call this function instead of changing "Gem" directly
func collect_gem():
	Gem += 1
	print("Gems collected: ", Gem)
	
	# Check if we reached 5 gems
	if Gem >= 5:
		if Game.playerHP == 10:
			return 
		Gem = 0  # Reset gem count (change to 'Gem -= 5' if you want to keep extras)
		heal_player(5)

func heal_player(amount):
	# This logic ensures HP never exceeds MAX_HP
	if playerHP < MAX_HP:
		playerHP += amount
		
		# If we go over the limit, snap back to MAX_HP
		if playerHP > MAX_HP:
			playerHP = MAX_HP
			
		print("Healed! Current HP: ", playerHP)
