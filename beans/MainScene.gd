extends Control


const can = preload("res://BeanCan.tscn")
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	var newcan = can.instance()
	var position = Vector2(screen_size.x/2, screen_size.y/2)
	newcan.translate(position)
	self.add_child(newcan)
