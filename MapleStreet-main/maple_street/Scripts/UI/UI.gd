extends CanvasLayer

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
		$"../Container/temp_inventory".visible = true
		
	# hide inventory
	elif Global.current_pauser == Global.pausers.INVENTORY_BUTTON:
		hide_inventory()
		$"../Container/temp_inventory".visible = false

# pause street and show inventory
func show_inventory():
	pause(Global.pausers.INVENTORY_BUTTON)

# resume street and hide inventory
func hide_inventory():
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
		show_inventory()
		$"../Container/temp_help".visible = true
		
	# hide inventory
	elif Global.current_pauser == Global.pausers.INVENTORY_BUTTON:
		hide_inventory()
		$"../Container/temp_help".visible = false
