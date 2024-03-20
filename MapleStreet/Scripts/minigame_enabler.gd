extends Node2D

var none = "none"
var active_house = none


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("E"):
		print("Entering: ", active_house)


# HELPERS
# Activate a given house when player is close enough (in house area)
func _activate_house(body, house):
	print("\nActivating: ", house)
	if body.name == "Player":
		active_house = house
	
# Deactivates house when player leaves house area 
func _deactivate_house(body):
	print("Deactivating: ", active_house)
	if body.name == "Player":
		active_house = none
	
	
# RED SIGNALS
# Activate red house 
func _activate_red_house(body):
	_activate_house(body, "Red House")

# Deactivate red house 
func _deactivate_red_house(body):
	_deactivate_house(body)


# ORANGE SIGNALS
# Activate orange house 
func _activate_orange_house(body):
	_activate_house(body, "Orange House")

# Deactivate orange house 
func _deactivate_orange_house(body):
	_deactivate_house(body)
