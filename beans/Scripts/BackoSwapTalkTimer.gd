extends Timer

var new_wait


func _ready():
	new_wait = round(rand_range(1, 4))
	change_timer_length()

func _on_BackoSwapTalkTimer_timeout():
	change_timer_length()

# Change how long before the timer sends its next signal
# This will help keep the various background animations out of sync
# and make them seem more natural
func change_timer_length():
	new_wait = round(rand_range(1, 4))
	set_wait_time(new_wait)
