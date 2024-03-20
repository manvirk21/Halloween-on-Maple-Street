extends Node2D
var Player = preload("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

# Instantiates a player
func instantiate_player():
	# make player instance
	var player = Player.instantiate()
	
	# point camera to player
	var player_locator = player.get_node("PlayerLocator")
	player_locator.remote_path = get_node("Camera").get_path()
	
	# add player to scene
	add_child(player)
