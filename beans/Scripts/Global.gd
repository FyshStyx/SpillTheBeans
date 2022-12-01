# All code here taken from Godot docs: 
# https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html#custom-scene-switcher

extends Node

var current_scene = null
var background_animation = true
var bean_time = 3

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# Global vairable setter to determine if scenes load background animation
func set_background_animation(boolean):
	background_animation = boolean
	
func get_background_animation():
	return background_animation
	
	
# Use this global getter and setter to make sure mouth animation timing is synced
# with bean spawning so no overlaps.
func set_bean_time(t):
	bean_time = t
	
func get_bean_time():
	return bean_time


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()
	
	# Extra step written by me
	# Disable background animations if enable_animations is false
	if background_animation == false:
		current_scene.disable_background_animation()
		

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
