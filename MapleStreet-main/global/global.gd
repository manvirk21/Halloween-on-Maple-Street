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
var Street_Teddy_initial_position : Vector2
var Street_Teddy_reposition : Dictionary = {
	"maze" : [null, true],
	"bowling" : [null, false],
	"runner" : [null, true],
	"cupswap" : [null, true],
	"quiz" : [null, true]
} # [position : Vector2, sprite flip : bool]

# Teddy settings
var Teddy_resize_on : bool
var Teddy_sprite_edit_on : bool # to know if flipping and animations are allowed
var Teddy_sprite_flip : bool = false # to save last state of flip_h

# valid strings for minigames
var VALID_MINIGAMES = ["maze", "bowling", "runner", "cupswap", "quiz"]

# helpers for if dialog needs to pop up when returning from minigame
var dialog_after_minigame : bool = false
var dialog_key : String = "Instructions"
var dialog_minigame : String


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


# used within minigame scenes
func change_to_main_street(minigame : String, candy_acquired : bool):
	# signal to maple street that dialog needs to pop up upon loading
	dialog_after_minigame = true
	
	# assume minigame wasn't completed
	dialog_key = "Retry"
	
	# if candy was acquired 
	if candy_acquired:
		# give the candy
		Save.give_candy_to_Teddy(minigame)
	
		# update Teddy position and sprite
		var settings = Street_Teddy_reposition[minigame]
		Street_Teddy_global_position = settings[0]
		Teddy_sprite_flip = settings[1]
		
		# select dialog blurb
		dialog_key = "Completion"
		active_minigame = minigame

	# change scene to maple street
	get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")


# resets teddy's position
func reset_teddy_position():
	Street_Teddy_global_position = Street_Teddy_initial_position
