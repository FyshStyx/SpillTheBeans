extends RigidBody2D


var target_head
var selected

# Called when the node enters the scene tree for the first time.
func _ready():
	target_head = "None"
	selected = false

func set_target_head(head):
	target_head = head
	
func get_target_head():
	return target_head

func select_can():
	selected = true
	
func unselect_can():
	selected = false

func d_select():
	if selected == true:
		queue_free()
		

# When can is clicked, highlight it
func _on_Can_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if event.pressed:
			# Call the unselect method from every can in scene
			# Have to use this REALTIME variable, or function seems to run after 
			# I set select to "true"
			get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "cans", "unselect_can")
			
			# Call the select method for this particular can
			self.select_can()
			
			get_tree().call_group("cans", "d_select")
			
			
	
	
