extends RigidBody2D


var target_head


# Called when the node enters the scene tree for the first time.
func _ready():
	target_head = "None"

func set_target_head(head):
	target_head = head
	
func get_target_head():
	return target_head
