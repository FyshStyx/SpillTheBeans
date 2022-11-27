extends RigidBody2D

# Use this variable to check if this can has been "caught" yet
var in_stack = true

#Override of default behaviour
func get_class():
	return "Can"

# Create joints between colliding rigid bodies so the stack is more "stable"
# (Possible mechanic, you lose when hand dips past certain degree of tilt??)
func _on_Can_body_entered(body):

	if in_stack == false:
		#print("detected_collision from can %s" % get_name())
		#set_mass(0)
		#set_gravity_scale(40)
		
		#self.set_linear_damp(10)
		
		
		# Get path to cans
		var path_a = self.get_path()
		var path_b = body.get_path()
		
		# Get location of can
		var curr_pos = get_position()
		
		# Get dimensions of can
		# We plan to create two joints, one on eather edge of the can
		# Hopefully will give a stable, jitter free joint
		# This assumes that the joint only is created if the can lands flush on the top
		# of another body (will need to take into account degrees of rotation for other joints
		var shape_dimensions = $CollisionShape2D.shape.extents
		var right_edge = curr_pos.x + shape_dimensions.x
		var left_edge = curr_pos.x - shape_dimensions.x
		var bottom_edge = curr_pos.y + shape_dimensions.y
		
		#Create left joint
		var joint_pos = Vector2(left_edge, bottom_edge)
		create_joint(joint_pos, path_a, path_b)
		
		#Create right joint
		joint_pos = Vector2(right_edge, bottom_edge)
		create_joint(joint_pos, path_a, path_b)
		
		
		# Prevent further joints from being created
		in_stack = true
	

func create_joint(pos, path_a, path_b):
	# Initialise a new pinjoint2D
	var joint = PinJoint2D.new()
	get_parent().add_child(joint)
	
	
	joint.set_position(pos)
	joint.set_softness(30)
	
	# Set current can and colliding body as joined nodes
	joint.set_node_a(path_a)
	joint.set_node_b(path_b)
