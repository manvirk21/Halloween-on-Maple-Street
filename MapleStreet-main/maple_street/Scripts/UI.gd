extends CanvasLayer

signal ChangeScene
var game_paused : bool = false

# Dialog helpers
var dialog_not_started : bool = true # to know if dialog needs to be initialized
var dialog_running : bool = false # to know to keep showing dialog
var dialog_finished : bool = false # to know when to change scene

var dialog_file : String = "res://maple_street/Scripts/Dialog.json"
var dialog_dict : Dictionary = JSON.parse_string(FileAccess.get_file_as_string(dialog_file))
var minigame_dialog : Array # dialog lines for corresponding minigame
var dialog_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	game_paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Change scene, if applicable
	if Input.is_action_just_pressed("E"):
		if Global.minigame_ready and dialog_not_started:
			start_dialog()
	
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
	$DialogBox.visible = true
	$Dialog.visible = true
	
	# get dialog for minigame based on the state of the minigame
	minigame_dialog = dialog_dict[Global.active_minigame][Global.get_minigame_state()]
	
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
	
	# resume scene and hide 
	resume()
	$DialogBox.visible = false
	$Dialog.visible = false
	
	emit_signal("ChangeScene")
	
# show/hide inventory 
func toggle_inventory():
	if game_paused:
		hide_inventory()
	else:
		show_inventory()

# pause street and show inventory
func show_inventory():
	pause()

# resume street and hide inventory
func hide_inventory():
	resume()

# pause street 
func pause():
	game_paused = true
	get_tree().paused = true
	
# resume street   
func resume():
	game_paused = false
	get_tree().paused = false
	
