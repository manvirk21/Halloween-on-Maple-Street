extends Node

# helpers to interact with save data
var json = JSON.new()
var save_file_name : String = "res://global/save_data/game.json"
var save_data : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(save_file_name))

# valid minigame states
var STATES = Global.VALID_STATES
var MINIGAMES = Global.VALID_MINIGAMES

# returns all minigame states
func get_minigame_states():
	return save_data["minigames"]

# returns candy inventory 
func get_candy_inventory():
	return save_data["candy"]

# adds one to the candy for the chosen minigame
func give_candy_to_Teddy(minigame):
	if minigame in MINIGAMES:
		save_data["candy"][minigame] += 1
		_save()

# set minigame state 
func set_minigame_state():
	pass
	
# saves game data
func _save():
	# get save data
	var data_as_json_string = JSON.stringify(save_data)
	
	# open save file
	var save_file = _open_save_file()
	
	# save
	save_file.store_line(data_as_json_string)

# (re)load game data
func _load():
	save_data = JSON.parse_string(FileAccess.get_file_as_string(save_file_name))

# reset game data
func reset():
	# open save file
	var save_file = _open_save_file()
	
	# get reset save data
	var reset_file_name : String = "res://global/save_data/reset.json"
	var reset_data_dict = JSON.parse_string(FileAccess.get_file_as_string(reset_file_name))
	var reset_data_string = JSON.stringify(reset_data_dict)
	
	# save 
	save_file.store_line(reset_data_string)

func _open_save_file():
	return FileAccess.open(save_file_name, FileAccess.WRITE)
