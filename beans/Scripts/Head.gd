extends Area2D


var can = preload("res://Scenes/BeanCan.tscn")
var light_tween
var tween_values

# Called when the node enters the scene tree for the first time.
func _ready():
	$"SpeechBubble".hide()
	light_tween = $Tween
	tween_values = [Color(1,1,1,1), Color(2,2,2,1)]


func create_new_can(target_head):
	update_speech_bubble(target_head)
	flash_speech_bubble()
	launch_can(target_head)


# Change the sprite show in the speech bubble to match the target
# of the can about to be created
func update_speech_bubble(target):
	var head_sprite = $"SpeechBubble/TargetHead"
	
	if target == "Bluford":
		head_sprite.set_bluford()
	elif target == "Ewart":
		head_sprite.set_ewart()
	elif target == "Ferdo":
		head_sprite.set_ferdo()
	elif target == "Gorm":
		head_sprite.set_gorm()
	


# Displays the speech bubble to the player before auto-hiding
func flash_speech_bubble():
	#Access the speech bubble sprite and run its show method
	$"SpeechBubble".show()
	#Acess the hide bubble timer and run its start method
	$"HideBubble".start()
	


func launch_can(target_head):
	# Create new can instance
	var new_can = can.instance()
	
	# Add can to the scene
	get_parent().add_child(new_can)
	
	# Move can to center of head. Due to z-axis, can will be behind
	# the character sprite
	new_can.set_position(get_position())
	
	# Add the target head information to the can
	new_can.set_target_head(target_head)
	
	# Make unpickable
	new_can.set_pickable(false)
	
	# Determine orientation of head on gamescene
	var faces_right = facing_right()
	var imp
	if faces_right:
		imp = Vector2(100,0)
	else:
		imp = Vector2(-100,0)
	
	# Yeet that bad body towards the ear
	new_can.apply_central_impulse(imp)


# Use the nodes rotation to determine whether the node is facing
# left or right
func facing_right():
	var r = get_rotation()
	var face_right
	
	if r == 0:
		face_right = true
	else:
		face_right = false
		
	return face_right


# TODO pull can towards head
# When a head is clicked make it so any selected can
# (which should only ever be one - although there may be
# a specific way to reduce method calls here) is immediately moved
# here. If that can is at the correct target head, increment score by 1
# otherwise game over
func _on_Head_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			# For every can in scene, run its "attempt_eat" function
			get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "cans", "attempt_eat", get_name(), position)

# These signals were declared in the body of NewBeans.gd
# I then connected them through the editor (non-advanced mode)
# I then manually changed the below functions to accept 1 argument
# When I emit the signals, I send a single argument (target_head) and
# it all works out fine. Hopefully this summary helps get your head around custom
# signals, because the documentation is pretty light on all of this.
func _on_NewBeans_bluford_trigger(target_head):
	create_new_can(target_head)

func _on_NewBeans_ewart_trigger(target_head):
	create_new_can(target_head)

func _on_NewBeans_ferdo_trigger(target_head):
	create_new_can(target_head)

func _on_NewBeans_gorm_trigger(target_head):
	create_new_can(target_head)



# Go from no glow to glow. Triggered by hovering over the head
func start_glow():
	# Note that we are blindly tageting the node Character
	# this is not a node in Head, but it is a node in all of our characters
	# there is probably a safer way to do this by inheriting this script into 
	# a subscript which all our characters could use - but since
	# this Jam is almost over we just gonna do this
	# P.S The reason I do this is so the speech bubble doesn't glow, just the character sprite
	light_tween.interpolate_property($Character, "modulate", tween_values[0], tween_values[1], 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	light_tween.start()

# When the tween finishes, swap the order of the values in the list
# this effectively swaps the start and end color values
# e.g. started at no glow, end at glow - need to swap for next tween run
func _on_Tween_tween_completed(_object, _key):
	tween_values.invert()
	start_glow()

func _on_Head_mouse_entered():
	start_glow()

# Stop tween and forcibly set modulate to default (remove glow basically)
func _on_Head_mouse_exited():
	print("Mouse exited")
	# Check if the tween is actually running
	if light_tween.is_active():
		print("Detected active tween")
		# Stop tween and remove from can (better than stop as stop just pauses the running tween
		# so it will cause problems if we try to initialise another one from start glow)
		light_tween.remove_all()
		# Reset head sprite modulate to default
		$Character.set_modulate(Color(1,1,1,1))



