extends Area2D


var can = preload("res://Scenes/BeanCan.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$"SpeechBubble".hide()


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
	# Move can to center of head. Due to z-axis, can will be behind
	# the character sprite
	new_can.set_position(get_position())
	
	# Add the target head information to the can
	new_can.set_target_head(target_head)
	
	# Add can to the scene
	get_parent().add_child(new_can)
	
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
# When can is clicked, make it emit a signal to all heads
# causing them to glow
# When a head is clicked make it so any selected can
# (which should only ever be one - although there may be
# a specific way to reduce method calls here) is immediately moved
# here. If that can is at the correct target head, increment score by 1
# otherwise game over
#Note need to make sure I adjust game so that you can't pick
# cans while they are in head hitbox (otherwise you might change can
# selection when just trying to select a head)
# maybe make cans unpickable until they hit the gravity well?
# could scale them up to size when they hit the gravity well
# to make it more obvious you can't click them yet


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
