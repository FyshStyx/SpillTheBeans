extends KinematicBody2D

export var speed = 400
var screen_size

# TODO make it so point of game is to get "beans" and "spicy beans" to left and right of screen
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("movement_right"):
		velocity.x += 1
	elif Input.is_action_pressed("movement_left"):
		velocity.x -=1
		
	#Normalise vectors (overkill probably since only left/right possible)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed	
	
	#Update position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
