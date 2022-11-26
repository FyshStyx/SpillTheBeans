extends AnimatedSprite


#Swap between listening and talking animation when triggered
func _on_BackoSwapTalkTimer_timeout():
	var curr_animation = get_animation()
	
	if curr_animation == "Listening":
		set_animation("Talking")
	elif curr_animation == "Talking":
		set_animation("Listening")
