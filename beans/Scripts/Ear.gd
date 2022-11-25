extends Area2D

var middle_x
var middle_y

func _ready():
	var screen_size = get_viewport_rect().size
	middle_x = screen_size.x / 2
	middle_y = screen_size.y / 2


# Game over when a can collides with the ear
func _on_Ear_body_entered(body):
	
	if body.get_class() == "Can":
		print("game over")
#		var txt = RichTextLabel.new()
#		txt.set_text("GAME OVER")
#		txt.set_position(Vector2(middle_x, middle_y))
#		get_parent().add_child(txt)
