extends Node

# Minigame settings : keep track of which minigame is accessible, if any
const NONE : String = "None"
var active_minigame : String = NONE
var minigame_ready : bool = false

# Teddy Speeds
const NORMAL_SPEED : float = 500#275
const GRASS_SPEED : float = 215
var Teddy_Speed : float = NORMAL_SPEED # used by Street Teddy scene

# Street Teddy position
var Street_Teddy_gp_not_initialized : bool = true
var Street_Teddy_global_position : Vector2
var Street_Teddy_maze_completed_position : Vector2

# Teddy settings
var Teddy_resize_on : bool
var Teddy_sprite_flip_on : bool # to know if flipping is allowed
var Teddy_sprite_flip : bool = false # to save last state of flip_h

# Dialog tracker helpers, see Dialog.json for dialog strings
const MINIGAME_STATES = ["first", "incomplete", "finished"] # [0, 1, 2]
var Minigame_State = {
	"maze" : 0,
	"bowling" : 0,
	"runner" : 0
}

# returns key for dialog dictionary of active minigame based on it's state
func get_minigame_state():
	return MINIGAME_STATES[Minigame_State[active_minigame]]

# Change Teddy settings
func set_Teddy_settings(resize : bool, sprite_flip : bool):
	Teddy_resize_on = resize
	Teddy_sprite_flip_on = sprite_flip

# Initialize Street Teddy
func initialize_Teddy_position(position : Vector2):
	Street_Teddy_global_position = position
	Street_Teddy_gp_not_initialized = false
