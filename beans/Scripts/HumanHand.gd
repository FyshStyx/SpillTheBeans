extends RigidBody2D

var speed = 30
var additional_torque = 200

# Seems to be called every frame that the node is NOT "sleeping" (this is why controls would time out if AFK)
func _integrate_forces(state):
	handle_movement(state)
	counteract_cans_linear(state)
	counteract_cans_torque(state)
	


# Move hand left and right based off input
# Impulse doesn't make a lot of sense considering
# I have dampening set to -1 (i.e. off)
func handle_movement(state):
	if Input.is_action_pressed("movement_right"):
		state.apply_central_impulse(Vector2(speed,0))
	elif Input.is_action_pressed("movement_left"):
		state.apply_central_impulse(Vector2(-1 * speed,0))
		


# Used to "push back" against the linear impulses imparted from colliding cans
# Note: Positive "y" is actually "down" in Godot
func counteract_cans_linear(state):
	var lin_vel = state.get_linear_velocity()
	
	# If can is moving up or down, dampen movement
	# with an equal but opposing force
	# Also creates a nice bobbing animation
	if lin_vel.y != 0:
		var opp_y = lin_vel.y * -1
		state.add_central_force(Vector2(0, opp_y))
		

# Used to push back against the rotational impulses imparted from colliding cans
# (especially those landing close to the edges of the hand)
# Might be the cause of cans "glitching" and phasing through each other
func counteract_cans_torque(state):
	
	var ang_vel = state.get_angular_velocity()
	var rotation = get_global_rotation_degrees()
	#print("Angle V: %s, Rot: %s" % [ang_vel, rotation])
	
	if rotation > 0.5:
		state.add_torque(-1 * additional_torque)
	elif rotation < -0.5:
		state.add_torque(additional_torque)
	else: #To prevent constant shaking back and forth, rapidly remove torque in sweet spot
		var curr_torque = get_applied_torque()
		#print("Old Torque: %s" % get_applied_torque())
		set_applied_torque(curr_torque / 2)
		#print("New Torque: %s" % get_applied_torque())
