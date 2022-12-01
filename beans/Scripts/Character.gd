extends AnimatedSprite

var audio_player

func _ready():
	set_animation("default")
	_set_playing(false)


# Start the talking animation
func start_talking():
	# Change from mouth closed state
	set_animation("talk")
	
	# Start animation
	_set_playing(true)
	
	

func stop_talking():
	set_animation("default")
	_set_playing(false)

# When the speech bubble is hidden, stops the mouth from moving
# this signal was manually attached in each character - could have been
# easier if I included the character sprite in the parent head class
func _on_HideBubble_timeout():
	stop_talking()
