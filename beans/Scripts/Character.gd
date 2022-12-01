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
	
	get_parent().get_node("TalkAudio")._set_playing(true)
	get_parent().get_node("TalkTimer").start()
	
	

func stop_talking():
	set_animation("default")
	_set_playing(false)
	
	get_parent().get_node("TalkAudio")._set_playing(false)
	


func _on_TalkTimer_timeout():
	stop_talking()
