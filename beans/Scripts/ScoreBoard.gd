extends Label


var total_score

# Called when the node enters the scene tree for the first time.
func _ready():
	total_score = 0
	set_text("Score: %s" % total_score)


func add_score():
	total_score += 1
	set_text("Score: %s" % total_score)

func get_score():
	return total_score
