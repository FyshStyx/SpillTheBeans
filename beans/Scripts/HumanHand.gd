extends RigidBody2D

var speed = 30
var screen_size

# TODO make it so point of game is to get "beans" and "spicy beans" to left and right of screen
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Seems to be called whenever a force is imparted on body?
func _integrate_forces(state):
	pass

# Called every frame
func _process(delta):
	
	if Input.is_action_pressed("movement_right"):
		apply_central_impulse(Vector2(speed,0))
	elif Input.is_action_pressed("movement_left"):
		apply_central_impulse(Vector2(-1 * speed,0))
