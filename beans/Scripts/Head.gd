extends StaticBody2D

const speech_bubble = preload("res://Scenes/Speech Bubble.tscn")

var screen_size
var middle


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	middle = screen_size.x / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Create a new speech bubble
func _on_Timer_timeout():
	var new_speech = speech_bubble.instance()
	var speech_pos = get_position()
	
	#Off set speech bubble based on which side of screen head is on
	if speech_pos.x < middle:
		speech_pos.x += 250
	else:
		speech_pos.x -= 250
	
	new_speech.set_position(speech_pos)
	get_parent().add_child(new_speech)
	
