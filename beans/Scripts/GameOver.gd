extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Handles post-game logic
func game_over():
	# Reveal game over pop-up
	show()
	
	print("game over")


func _on_Play_Again_pressed():
	Global.goto_scene("res://GameScene.tscn")


func _on_Play_Home_pressed():
	Global.goto_scene("res://MainMenu.tscn")
