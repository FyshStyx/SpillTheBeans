extends RigidBody2D

# Use this variable to check if this can has been "caught" yet
var in_stack = false

# Increase gravity when touching another can/hand
# Makes friction more effective and "sticky"
func _on_Can_body_entered(body):

	
	if in_stack == false:
		print("detected_collision from can %s" % get_name())
		set_mass(0)
		set_gravity_scale(40)
		in_stack = true
	
