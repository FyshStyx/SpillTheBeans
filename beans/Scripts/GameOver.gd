extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Handles post-game logic
func game_over():
	# Pause game
	get_tree().paused = true
	
	# Reveal game over pop-up
	show()
	
	# Play audio
	$AudioStreamPlayer._set_playing(true)
	
	#Change text in game over screen
	var score = get_tree().get_root().get_node("GameScene/ScoreBoard").get_score()
	
	var  string_score = String(score)
	
	$FinalScore.set_text(string_score)
	
	#Reset the global vars in case play again (annoying bug do this a better way
	#if you have time)
	Global.set_bean_time(3)
	Global.set_cans(0)


func _on_Play_Again_pressed():
	get_tree().paused = false
	Global.goto_scene("res://GameScene.tscn")


func _on_Play_Home_pressed():
	get_tree().paused = false
	Global.goto_scene("res://MainMenu.tscn")
