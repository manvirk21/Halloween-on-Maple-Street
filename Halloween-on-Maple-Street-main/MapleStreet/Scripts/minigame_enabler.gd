extends Node2D
@onready var MouseDoorLight: Sprite2D = find_child("MouseDoorLight") #set variable Congrats for the FinishScreen Sprite2D
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
	MouseDoorLight.visible = true 
	_activate_minigame(body, "Maze")


func _maze_area_exited(body):
	MouseDoorLight.visible = false 
	_deactivate_minigame(body)