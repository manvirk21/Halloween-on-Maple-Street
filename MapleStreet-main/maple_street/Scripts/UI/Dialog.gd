extends CanvasLayer

signal ChangeScene
var game_paused : bool = false

# Dialog helpers
var dialog_not_started : bool = true # to know if dialog needs to be initialized
var dialog_running : bool = false # to know to keep showing dialog
var dialog_finished : bool = false # to know when to change scene
var dialog_index : int = 0
var dialog_feedback_started : bool = false

# JSON file with minigame info strings
var dialog_file : String = "res://maple_street/Scripts/UI/Dialog.json"
var dialog_dict : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(dialog_file))

# Minigame info
var minigame_info : Dictionary # includes dialog, npc name and other info
var minigame_dialog : Array # dialog lines for corresponding minigame
var minigame_npc : String

# Dialog box node
var dialog_box : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# check if instruction dialog shuld be started
	var user_input = Input.is_action_just_pressed("DIALOG") 
	var instructions_dialog = user_input and Global.minigame_ready
	
	# check if retry/completion dialog shuld be started
	var start_feedback_dialog = Global.dialog_after_minigame and not dialog_feedback_started # makes sure feedback dialog starts
	var continue_feedback_dialog = user_input and Global.dialog_after_minigame # makes sure sure feedback continues
	var feedback_dialog = start_feedback_dialog or continue_feedback_dialog
	
	# Start dialog, if applicable
	if instructions_dialog or feedback_dialog:
		if dialog_not_started:
			start_dialog()
			
			# turn flag off so that feedback dialog displays correctly
			if start_feedback_dialog:
				dialog_feedback_started = true
	
		elif dialog_running:
			display_dialog_text()
		
		elif dialog_finished:
			finish_dialog()

# start dialog
func start_dialog():
	# dialog is now running
	dialog_not_started = false
	dialog_running = true
	
	# pause street, display dialog
	pause()
	$Dialog.visible = true
	$NPC_Name.visible = true

	# if entering a minigame get dialog on the state of the minigame
	minigame_info = dialog_dict[Global.active_minigame]
	minigame_dialog = minigame_info[Global.dialog_key]
	
	# display name of minigame NPC
	minigame_npc = minigame_info["NPC"]
	$NPC_Name.text = minigame_npc + ":"
	
	# display correct dialog box
	dialog_box = get_node(minigame_npc + "DialogBox")
	dialog_box.visible = true
	
	# display dialog text
	display_dialog_text()
	
func display_dialog_text():
	# display next dialog line
	$Dialog.text = minigame_dialog[dialog_index]
	dialog_index += 1
	
	# check if all lines have been shown
	if dialog_index == minigame_dialog.size():
		dialog_index = 0
		dialog_running = false
		dialog_finished = true

func finish_dialog():
	dialog_not_started = true
	dialog_finished = false
	
	# reset globals
	Global.dialog_after_minigame = false
	Global.minigame_ready = false
	
	# resume scene and hide dialog nodes
	resume()
	dialog_box.visible = false
	$Dialog.visible = false
	$NPC_Name.visible = false
	
	# if starting minigame, send signal to MapleStreet node to change scene to minigame
	if Global.dialog_key == "Instructions":
		emit_signal("ChangeScene")
	
	# reset dialog key
	else:
		Global.dialog_key = "Instructions"


# pause street 
func pause():
	Global.is_game_paused = true
	Global.current_pauser = Global.pausers.DIALOG
	get_tree().paused = true


# resume street   
func resume():
	Global.is_game_paused = false
	Global.current_pauser = Global.pausers.NONE
	get_tree().paused = false
