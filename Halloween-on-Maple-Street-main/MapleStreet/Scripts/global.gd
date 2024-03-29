extends Node

# Minigame settings : keep track of which minigame is accessible, if any
const NONE : String = "None"
var active_minigame : String = NONE
var minigame_ready : bool = false

# Street Teddy position
var Street_Teddy_gp_not_initialized : bool = true
var Street_Teddy_global_position : Vector2

# Teddy settings
var Teddy_resize_on : bool
var Teddy_sprite_flip_on : bool # to know if flipping is allowed
var Teddy_sprite_flip : bool = false # to save last state of flip_h

# Change Teddy settings
func set_Teddy_settings(resize : bool, sprite_flip : bool):
	Teddy_resize_on = resize
	Teddy_sprite_flip_on = sprite_flip

# Initialize Street Teddy
func initialize_Teddy_position(position : Vector2):
	Street_Teddy_global_position = position
	Street_Teddy_gp_not_initialized = false
