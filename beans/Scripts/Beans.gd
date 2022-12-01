extends StaticBody2D



var move_tween
var left
var right
var speed = 30
var velocity = Vector2.ZERO
# Index of each y value matches what height I want the node at
# Remember that index starts at 0
var y_values = [1000,930,860,790,720,650,580,510,440,370,300,230]

# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween = $"MoveTween"
	left = position.x - 50
	right = position.x + 50
	velocity.x = 1

# Constantly move left / right based off movement
func _process(delta):
	
	#update direction if hit edge screen
	if position.x == right:
		velocity.x = -1
	elif position.x == left:
		velocity.x = 1
		
	velocity = velocity.normalized() * speed	
	
	#Update position
	position += velocity * delta
	position.x = clamp(position.x, left, right)


func move_beans():
	var beans_in_play = Global.get_cans()
	move_tween.interpolate_property(self, "position", position, Vector2(position.x, y_values[beans_in_play]), 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	move_tween.start()
	
	
