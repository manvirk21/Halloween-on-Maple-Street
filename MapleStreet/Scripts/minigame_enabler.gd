extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

# HELPERS
# Activate a given house when player is close enough (in house area)
func _activate_minigame(body, minigame : String):
	if body.name == "Street_Teddy":
		Global.active_minigame = minigame
		Global.minigame_ready = true
	
# Deactivates house when player leaves house area 
func _deactivate_minigame(body):
	if body.name == "Street_Teddy":
		Global.active_minigame = Global.NONE
		Global.minigame_ready = false


# MAZE SIGNALS
func _maze_area_entered(body):
	_activate_minigame(body, "Maze")


func _maze_area_exited(body):
	_deactivate_minigame(body)
