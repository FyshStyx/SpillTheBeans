extends StaticBody2D

var rotation_speed = 0.2


# Constantly spin the wheel
func _process(delta):
	rotation += rotation_speed * delta
