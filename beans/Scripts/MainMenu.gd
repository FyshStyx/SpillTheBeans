extends Control

var background_animation

func _ready():
	background_animation = true

# Start the game
func _on_Play_pressed():
	#get_tree().change_scene("res://GameScene.tscn")
	Global.goto_scene("res://GameScene.tscn", background_animation)


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		background_animation = true
		$Background/Conversations.show()
	else:
		background_animation = false
		$Background/Conversations.hide()
