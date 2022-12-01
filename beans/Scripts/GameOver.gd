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
	
	#Change text in game over screen
	var score = get_tree().get_root().get_node("GameScene/ScoreBoard").get_score()
	
	var  string_score = String(score)
	
	$FinalScore.set_text(string_score)


func _on_Play_Again_pressed():
	Global.goto_scene("res://GameScene.tscn")


func _on_Play_Home_pressed():
	Global.goto_scene("res://MainMenu.tscn")
