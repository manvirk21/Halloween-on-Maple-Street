extends Node2D

# dialog helpers
var scene : String
var scene_dialog : Array
var dialog_index : int = 0

# dialog info
var dialog_file : String = "res://intro_outro/Scripts/dialog.json"
var all_dialog : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(dialog_file))

# scene to switch to after dialog is over
var end_options : String = "res://maple_street/Scenes/EndOptions.tscn"
var maple_street : String = "res://maple_street/Scenes/Maple_Street.tscn"
var next_scene : String


# Called when the node enters the scene tree for the first time.
func _ready():
	# display correct background and save scene info
	if not Save.is_intro_viewed():
		scene = "intro"
		next_scene = maple_street
		$Background/Outro.visible = false
		Save.set_intro_viewed()
	else:
		scene = "outro"
		next_scene = end_options
		$Background/Intro.visible = false
		Save.set_outro_viewed()
	
	# save dialog
	scene_dialog = all_dialog[scene]
	
	# start displaying dialog
	update_dialog()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# wait for user input to update dialog
	if Input.is_action_just_pressed("DIALOG"):
		update_dialog()

# updates dialog 
func update_dialog():
	# switch scene if dialog is over
	if dialog_index == scene_dialog.size():
		get_tree().change_scene_to_file(next_scene)
		return
	
	# get update info
	var dialog = scene_dialog[dialog_index]
	
	# update text
	$Speaker.text = dialog[0] + ":"
	$Dialog.text = dialog[1]
	
	# update dialog box to match speaker
	$DialogBox/Teddy.visible = (dialog[0] == "Teddy")
	$DialogBox/Buddy.visible = (dialog[0] == "Buddy")
	
	# update dialog index for next time
	dialog_index += 1
