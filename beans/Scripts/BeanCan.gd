extends RigidBody2D


var target_head
var selected
var light_tween
var tween_values

# Called when the node enters the scene tree for the first time.
func _ready():
	target_head = "None"
	selected = false
	light_tween = $Tween
	tween_values = [Color(1,1,1,1), Color(2,2,2,1)]


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
func attempt_eat(head):
	if selected == true:
		if target_head == head:
			print("Correct head!")
			# Todo figure out how to trigger a signal to increase score
		else:
			print("Wrong head")
			print("Can target = %s" % target_head)
			print("Selected head = %s" % head)
			get_tree().paused = true


# Go from no glow to glow. Triggered by clicking the can
func start_glow():
	light_tween.interpolate_property(self, "modulate", tween_values[0], tween_values[1], 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	light_tween.start()

# When the tween finishes, swap the order of the values in the list
# this effectively swaps the start and end color values
# e.g. started at no glow, end at glow - need to swap for next tween run
func _on_Tween_tween_completed(object, key):
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
			
	
	

