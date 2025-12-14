extends CanvasLayer

# This allows you to type the level name in the Inspector for each scene
@export var level_name: String = "Level 1"
@export var duration: float = 2.0  # How long it stays visible
@export var fade_time: float = 1.0 # How long it takes to fade out

@onready var label = $TitleLabel

func _ready():
	# 1. Set the text
	label.text = level_name
	
	# 2. Wait for the duration (e.g., 2 seconds)
	# We use 'await' so the code pauses here
	await get_tree().create_timer(duration).timeout
	
	# 3. Create the Fade Out effect
	var tween = create_tween()
	# Change the "modulate" (color/transparency) alpha to 0 (invisible) over 'fade_time' seconds
	tween.tween_property(label, "modulate:a", 0.0, fade_time)
	
	# 4. Delete this entire node when the animation finishes
	tween.tween_callback(queue_free)
