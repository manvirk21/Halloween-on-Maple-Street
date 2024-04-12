extends CanvasLayer

var game_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_paused = false
	get_node("Blur").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# show/hide inventory 
func toggle_inventory():
	if game_paused:
		hide_inventory()
	else:
		show_inventory()

# pause street and show inventory
func show_inventory():
	game_paused = true
	get_node("Blur").visible = true
	get_tree().paused = true

# resume street and hide inventory
func hide_inventory():
	game_paused = false
	get_node("Blur").visible = false
	get_tree().paused = false
