extends Node

# helpers to know if game is paused and by what
var is_game_paused : bool = false
enum pausers {HELP_BUTTON, INVENTORY_BUTTON, DIALOG, NONE}
var current_pauser : int

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
var Teddy_sprite_edit_on : bool # to know if flipping and animations are allowed
var Teddy_sprite_flip : bool = false # to save last state of flip_h

# valid strings for states and minigames
var VALID_STATES = ["Instructions", "Retry", "Fun Fact"]
var VALID_MINIGAMES = ["maze", "bowling", "runner", "cupswap", "quiz"]

# flag for if dialog needs to pop up when returning from minigame
var dialog_after_minigame : bool = false

# returns key for dialog dictionary of active minigame based on it's state
func get_minigame_state():
	var minigame_states = Save.get_minigame_states()
	return VALID_STATES[minigame_states[active_minigame]]

# Change Teddy settings
func set_Teddy_settings(resize : bool, sprite_flip : bool):
	Teddy_resize_on = resize
	Teddy_sprite_edit_on = sprite_flip

# Initialize Street Teddy
func initialize_Teddy_position(position : Vector2):
	Street_Teddy_global_position = position
	Street_Teddy_gp_not_initialized = false

# returns true if all minigames have been won, false otherwise
func is_game_won():
	var candy_inventory = Save.get_candy_inventory()
	var minigames_won : int = 0

	for minigame in VALID_MINIGAMES:
		if candy_inventory[minigame] > 0:
			minigames_won += 1
	
	return minigames_won == 5

# position Teddy at the exit of the maze
func move_Teddy_to_maze_exit():
	Street_Teddy_global_position = Street_Teddy_maze_completed_position
	
	# have Teddy facing the mouse
	Teddy_sprite_flip = true
