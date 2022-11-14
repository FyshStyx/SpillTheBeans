extends Node2D


const can = preload("res://BeanCan.tscn")
var screen_size
export var speed = 400
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity.x = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	#update direction if hit edge screen
	if position.x == screen_size.x:
		velocity.x = -1
	elif position.x == 0:
		velocity.x = 1
		
	velocity = velocity.normalized() * speed	
	
	#Update position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)


func _on_Timer_timeout():
	var newcan = can.instance()
	newcan.position = position
	owner.add_child(newcan)
