extends Area2D


func _on_Gravity_Well_body_entered(body):
	# Once a can enters this gravity well set it to be pickable
	if body.get_name() == "bean_can":
		body.set_pickable(true)
