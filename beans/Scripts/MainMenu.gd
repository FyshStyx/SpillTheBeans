extends Control

var background_animation

func _ready():
	background_animation = true

# Start the game
func _on_Play_pressed():
	#get_tree().change_scene("res://GameScene.tscn")
	Global.goto_scene("res://GameScene.tscn")


func _on_CheckButton_toggled(button_pressed):
	$AudioStreamPlayer._set_playing(true)
	if button_pressed:
		Global.set_background_animation(true)
		$Background/Conversations.show()
	else:
		Global.set_background_animation(false)
		$Background/Conversations.hide()


# Called when re-entering this scene from the main menu button - ensures that background state is consistent
func disable_background_animation():
	# Disable animation
	$Background/Conversations.hide()
	
	# Set button to off
	$"CheckButton".set_pressed(false) 
