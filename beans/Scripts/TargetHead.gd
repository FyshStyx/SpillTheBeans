# These helper functions allow for the sprite in the speech bubble to be updated
# (The one that tells the player who the next can should go to)

extends Sprite


var bluford_sprite = preload("res://Sprites/bluford.png")
var ewart_sprite = preload("res://Sprites/ewart.png")
var ferdo_sprite = preload("res://Sprites/ferdo.png")
var gorm_sprite = preload("res://Sprites/gorm.png")

var current_character

func _ready():
	current_character = "None"

func get_current_character():
	return current_character

func set_bluford():
	set_texture(bluford_sprite)
	current_character = "Bluford"
	
func set_ewart():
	set_texture(ewart_sprite)
	current_character = "Ewart"
	
func set_ferdo():
	set_texture(ferdo_sprite)
	current_character = "Ferdo"
	
func set_gorm():
	set_texture(gorm_sprite)
	current_character = "Gorm"
	
