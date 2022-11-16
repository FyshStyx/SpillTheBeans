extends RichTextLabel


var total_time = 0
var stopwatch_running = true


# Called when the node enters the scene tree for the first time.
func _ready():
	#Start timer at 0 seconds
	self.text = String(total_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if stopwatch_running == true:
		#Add time since last frame to total_time
		total_time += delta
		
		#Update scoreboard (with rounding)
		var rounded_time = stepify(total_time, 0.001)
		self.text = String(rounded_time)


#Toggle stopwatch
#func _on_Button_pressed():
#	if stopwatch_running == true:
#		stopwatch_running = false
#		print("stopped timer")
#	elif stopwatch_running == false:
#		stopwatch_running = true
#		print("started timer")
		

