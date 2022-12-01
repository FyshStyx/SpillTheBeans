extends Timer

var characters = ["Bluford", "Ewart", "Ferdo", "Gorm"]
var next_beans = {
	"source" : "", 
	"target" : ""
	}

# All signals run code in head.gd, but each signal only triggers
# an action from one of the four head nodes in the gamescene
signal bluford_trigger()
signal ewart_trigger()
signal ferdo_trigger()
signal gorm_trigger()

func _ready():
	# Randomise the seed of the random number generator
	randomize()
	# Create initial source and target
	generate_new_source_and_target()

# Will generate information determining from which character the next bean
# will spawn, and which character will be the target the beans are meant to
# be delivered to
func _on_NewBeans_timeout():
	
	# Emit signal for current source and target pair
	if next_beans["source"] == "Bluford":
		emit_signal("bluford_trigger", next_beans["target"])
	elif next_beans["source"] == "Ewart":
		emit_signal("ewart_trigger", next_beans["target"])
	elif next_beans["source"] == "Ferdo":
		emit_signal("ferdo_trigger", next_beans["target"])
	elif next_beans["source"] == "Gorm":
		emit_signal("gorm_trigger", next_beans["target"])
	
	# Update the signal for next firing
	generate_new_source_and_target()
	
	# Make next signal fire slightly sooner (up to a minimum time of 1 second)
	if wait_time > 1:
		wait_time = wait_time - 0.05
		Global.set_bean_time(wait_time)

# Update the next source/target pair by generating two indicies
# to select characters from our character list
func generate_new_source_and_target():
	var source_index = randi()%4
	var target_index = randi()%4
	
	# Continue to regenerate target_index until it is not the same
	# as source index
	while target_index == source_index:
		target_index = randi()%4
	
	# Now we have two different characters and we can update the next_beans
	# dictionary
	set_source(characters[source_index])
	set_target(characters[target_index])
	
	

func get_source():
	return next_beans["source"]
	
func set_source(source):
	next_beans["source"] = source

func get_target():
	return next_beans["target"]
	
func set_target(target):
	next_beans["target"] = target
