extends CanvasLayer

var MINIGAMES = Global.VALID_MINIGAMES
@onready var CandySprites : Dictionary = {
	"maze" : $Inventory/MazeCandy,
	"bowling" : $Inventory/BowlingCandy,
	"runner" : $Inventory/RunnerCandy,
	"cupswap" : $Inventory/CupSwapCandy,
	"quiz" : $Inventory/QuizCandy
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# show/hide inventory 
func toggle_inventory():
	# show inventory
	if not Global.is_game_paused:
		show_inventory()
		
	# hide inventory
	elif Global.current_pauser == Global.pausers.INVENTORY_BUTTON:
		hide_inventory()

# pause street and show inventory
func show_inventory():
	if not Global.is_game_paused:
		# pause game 
		pause(Global.pausers.INVENTORY_BUTTON)
		
		# show inventory background
		$Inventory/Background.visible = true
		
		# show candy that has been collected only
		var candy_status = Save.get_candy_inventory()
		for minigame in MINIGAMES:
			if candy_status[minigame] > 0:
				CandySprites[minigame].visible = true

# resume street and hide inventory
func hide_inventory():
	if Global.current_pauser == Global.pausers.INVENTORY_BUTTON:
		# hide inventory background
		$Inventory/Background.visible = false
	
		# hide candy
		for minigame in MINIGAMES:
			CandySprites[minigame].visible = false
		
		# resume game
		resume()



# pause street 
func pause(pauser):
	Global.is_game_paused = true
	Global.current_pauser = pauser
	get_tree().paused = true
	
# resume street   
func resume():
	Global.is_game_paused = false
	Global.current_pauser = Global.pausers.NONE
	get_tree().paused = false


func _on_help_button_pressed():
	# show inventory
	if not Global.is_game_paused:
		pause(Global.pausers.HELP_BUTTON)
		$Help/temp_help.visible = true
		
	# hide inventory
	elif Global.current_pauser == Global.pausers.HELP_BUTTON:
		resume()
		$Help/temp_help.visible = false


func _on_button_pressed():
	hide_inventory()



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://maple_street/Scenes/TitleScreen.tscn") # Replace with function body.


func _on_help_back_pressed():
	resume()
	$Help/temp_help.visible = false
