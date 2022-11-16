extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#Increase gravity when touching another can/hand
func _on_Can_body_entered(body):
	set_gravity_scale(10)
	#Somehow make the velocity of the can tied directly to that of the hand
