extends Node

# helpers to interact with save data
var json = JSON.new()
var save_file_name : String = "res://global/save_data/game.json"
var save_data : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(save_file_name))

# valid minigames
var MINIGAMES = Global.VALID_MINIGAMES


# returns candy inventory 
func get_candy_inventory():
	return save_data["candy"]


# adds one to the candy for the chosen minigame
func give_candy_to_Teddy(minigame):
	if minigame in MINIGAMES:
		save_data["candy"][minigame] += 1
		_save()


# returns if intro has been viewed
func is_intro_viewed():
	return _is_scene_viewed("intro")


# returns if outro has been viewed
func is_outro_viewed():
	return _is_scene_viewed("outro")


# marks intro as viewed
func set_intro_viewed():
	save_data["intro"] = 1
	_save()


# marks outro as viewed
func set_outro_viewed():
	save_data["outro"] = 1
	_save()


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


# checks if scene has been viewed based on save data
func _is_scene_viewed(scene : String):
	if save_data[scene] == 0:
		return false
	
	return true


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
	_load()


# opens save file
func _open_save_file():
	return FileAccess.open(save_file_name, FileAccess.WRITE)
