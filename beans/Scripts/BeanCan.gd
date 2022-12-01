extends RigidBody2D


var target_head
var selected
var light_tween
var move_tween
var scale_tween
var tween_values
var default_sprite_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	target_head = "None"
	selected = false
	light_tween = $LightTween
	move_tween = $MoveTween
	scale_tween = $ScaleTween
	tween_values = [Color(1,1,1,1), Color(2,2,2,1)]
	
	# When a can is created, it should start at a small scale
	# to suggest to player they can't click it yet
	default_sprite_scale = $BeanCan.get_scale()
	$BeanCan.set_scale(default_sprite_scale / 2)

# Use this when can enters gravity well to appear normal again
func return_to_default_sprite_scale():
	scale_tween.interpolate_property($BeanCan, "scale", $BeanCan.scale, default_sprite_scale, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	scale_tween.start()

func set_target_head(head):
	target_head = head
	
func get_target_head():
	return target_head

func select_can():
	selected = true
	
func unselect_can():
	selected = false

func get_name():
	return "bean_can"
	

# If the can should be eaten by given head, increment score by 1
# if can shouldn't be eaten cause a gameover. Only run if can is
# actively selected
func attempt_eat(head, head_position):
	if selected == true:
		if target_head == head:
			# Stop the glowing
			stop_glowing_immediate()
			
			# Make can unpickable
			set_pickable(false)
			
			# Make can have no collisions + be static object
			$"CollisionShape2D".set_disabled(true)
			set_mode(RigidBody2D.MODE_STATIC)
			
			# Use tween to move can to head
			move_tween.interpolate_property(self, "position", position, head_position, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			move_tween.start()
			
			# Add one to score
			get_tree().call_group("score", "add_score")
			
		else:
			get_tree().call_group("end_game", "game_over")

# On a successful move, once the can reaches the head
# delete it from the game scene
func _on_MoveTween_tween_completed(_object, _key):
	queue_free()

# Go from no glow to glow. Triggered by clicking the can
func start_glow():
	light_tween.interpolate_property(self, "modulate", tween_values[0], tween_values[1], 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	light_tween.start()

# When the tween finishes, swap the order of the values in the list
# this effectively swaps the start and end color values
# e.g. started at no glow, end at glow - need to swap for next tween run
func _on_Tween_tween_completed(_object, _key):
	tween_values.invert()
	start_glow()


# Stop tween and forcibly set modulate to default (remove glow basically)
func stop_glowing_immediate():
	# Check if the tween is actually running
	if light_tween.is_active():
		# Stop tween and remove from can (better than stop as stop just pauses the running tween
		# so it will cause problems if we try to initialise another one from start glow)
		light_tween.remove_all()
		# Reset can modulate to default
		set_modulate(Color(1,1,1,1))
		
		

# When can is clicked, highlight it
func _on_Can_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton:
		if event.pressed:
			# Call the unselect method from every can in scene
			# Have to use this REALTIME variable, or function seems to run after 
			# I set select to "true"
			get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "cans", "unselect_can")
			
			# Stop all cans from glowing
			get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "cans", "stop_glowing_immediate")
			
			# Call the select method for this particular can
			self.select_can()
			
			# Start the glowing animation
			start_glow()
			
	
	




