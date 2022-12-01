extends Sprite


var rotate_tween
var tween_values

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_tween = $"RotateTween"
	tween_values = [-15, 15]
	start_anim()


func start_anim():
	rotate_tween.interpolate_property(self, "rotation_degrees", tween_values[0], tween_values[1], 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	rotate_tween.start()



func _on_RotateTween_tween_completed(_object, _key):
	# Reverse order of list so the tween plays in reverse to last tween
	tween_values.invert()
	
	start_anim()
