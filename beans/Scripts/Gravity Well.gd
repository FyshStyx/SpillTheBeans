extends Area2D


func _on_Gravity_Well_body_entered(body):
	# Once a can enters this gravity well set it to be pickable
	if body.get_name() == "bean_can":
		body.set_pickable(true)
		body.return_to_default_sprite_scale()
		
		#Update global count of cans in play
		Global.add_can()
		
		#Update the floating bean animation height
		get_tree().call_group("really_bad_signal", "move_beans")
		
