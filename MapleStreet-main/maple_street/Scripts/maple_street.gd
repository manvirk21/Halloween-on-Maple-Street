extends Node2D

var Street_Teddy = preload("res://player/Scenes/Street_Teddy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_Teddy()
	set_Teddy_settings()
	
	# when "Change Scene" is emitted, change_scene() will be called
	$UI.connect("ChangeScene", change_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Set Teddy settings : resize and sprite flip on
func set_Teddy_settings():
	var Teddy_resize = true
	var Teddy_sprite_flip = true
	
	Global.set_Teddy_settings(Teddy_resize, Teddy_sprite_flip)


# Instantiates Teddy
func instantiate_Teddy():
	# make Teddy instance
	var Teddy = Street_Teddy.instantiate()
	
	# get Teddy's initial position
	if Global.Street_Teddy_gp_not_initialized:
		Global.Street_Teddy_global_position = $InitialTeddyPosition.global_position
		Global.Street_Teddy_maze_completed_position = $MazeExitPosition.global_position
		Global.Street_Teddy_gp_not_initialized = false
	
	# position Teddy correctly
	Teddy.global_position = Global.Street_Teddy_global_position
	
	# set flip
	var Teddy_sprite = Teddy.get_node("Teddy_Sprite")
	Teddy_sprite.flip_h = Global.Teddy_sprite_flip
	
	# point camera to Teddy
	var Teddy_locator = Teddy.get_node("Locator")
	Teddy_locator.remote_path = $Camera.get_path()
	
	# add Teddy to scene
	add_child(Teddy)

# change scene to a minigame
func change_scene():
	# save Teddy's location
	Global.Street_Teddy_global_position = $Street_Teddy.global_position
	
	# save Teddy sprite flip
	var Teddy_sprite = $Street_Teddy/Teddy_Sprite
	#get_node("Street_Teddy").get_node("Teddy_Sprite")
	Global.Teddy_sprite_flip = Teddy_sprite.flip_h
	
	# change to the right minigame scene
	# make sure minigame folder and minigame scene have same name!
	var scene = "res://minigame/" + Global.active_minigame + "/Scenes/" + Global.active_minigame + ".tscn"
	get_tree().change_scene_to_file(scene)
	
	# hide blur 
	$UI/Blur.visible = false

# SIGNALS 
# Set Teddy's speed to normal when he's not in grass areas
func _on_Teddy_exits_grass(body):
	if body.name == "Street_Teddy":
		Global.Teddy_Speed = Global.NORMAL_SPEED

# Slow down Teddy when he's in grass areas
func _on_Teddy_enters_grass(body):
	if body.name == "Street_Teddy":
		Global.Teddy_Speed = Global.GRASS_SPEED

