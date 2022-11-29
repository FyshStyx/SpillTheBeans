extends Area2D


var can = preload("res://Scenes/BeanCan.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var speech = $"SpeechBubble"
	speech.hide()


func launch_can():
	var new_can = can.instance()
	new_can.set_position(get_position())
	get_parent().add_child(new_can)
	
	var faces_right = facing_right()
	var imp
	if faces_right:
		imp = Vector2(100,0)
	else:
		imp = Vector2(-100,0)
	
	new_can.apply_central_impulse(imp)


# Use the nodes x-scale to determine whether the node is facing
# left or right
func facing_right():
	var s = scale.x
	var face_right
	
	if s > 0:
		face_right = true
	else:
		face_right = false
		
	return face_right
	
func flash_speech_bubble(source_head):
	var speech = $"SpeechBubble"
	var hide_timer = $"SpeechBubble/HideBubble"
	var target = $"SpeechBubble/TargetHead"
	
	if source_head == "Bluford":
		target.set_bluford()
		speech.show()
		hide_timer.start()
	
	

# Launch a can towards center of game
func _on_NewBeans_timeout(source_head):
	flash_speech_bubble(source_head)
	launch_can()
