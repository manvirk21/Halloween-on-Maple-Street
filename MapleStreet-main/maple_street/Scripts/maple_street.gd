extends Node2D

var Street_Teddy = preload("res://player/Scenes/Street_Teddy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_Teddy()
	set_Teddy_settings()
	NPC_display()
	
	# when "Change Scene" is emitted, change_scene() will be called
	$Dialog.connect("ChangeScene", change_scene)


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
	
	# get Teddy's initial position and minigame finished positions
	if Global.Street_Teddy_gp_not_initialized:
		set_minigame_finished_positions()
		var initial_marker = $PositionMarkers/InitialTeddyPosition
		Global.Street_Teddy_global_position = initial_marker.global_position
		Global.Street_Teddy_initial_position = initial_marker.global_position
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

# save minigame finished positions (used to move Teddy)
func set_minigame_finished_positions():
	for minigame in Global.VALID_MINIGAMES:
		var marker_node = get_node("PositionMarkers/" + minigame + "FinishPosition")
		var minigame_position = marker_node.global_position
		# position is at index 0, sprite flip is at index 1
		Global.Street_Teddy_reposition[minigame][0] = minigame_position

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

# display NPC if appropriate
func NPC_display():
	# get minigame and candy indo
	var MINIGAMES = Global.VALID_MINIGAMES
	var candy_inventory = Save.get_candy_inventory()
	
	# get NPC sprites and collisions
	var NPCs = {
		"maze" : [$NPCs/Sprites/Mouse, $NPCs/MouseCollision],
		"bowling" : [$NPCs/Sprites/Bear, $NPCs/BearCollision],
		"runner" : [$NPCs/Sprites/Bunny, $NPCs/BunnyCollision],
		"cupswap" : [$NPCs/Sprites/Raccoon, $NPCs/RaccoonCollision],
		"quiz" : [$NPCs/Sprites/Owl, $NPCs/OwlCollision]
	}
	
	# make NPCs visible (and collideable) if Teddy got candy from respective minigame
	# by default, NPC sprites are hidden and collisions are disabled
	for minigame in MINIGAMES:
		if candy_inventory[minigame] > 0:
			NPCs[minigame][0].visible = true # show sprite
			NPCs[minigame][1].set_deferred("disabled", false) # enable collision

# SIGNALS 
# Set Teddy's speed to normal when he's not in grass areas
func _on_Teddy_exits_grass(body):
	if body.name == "Street_Teddy":
		Global.Teddy_Speed = Global.NORMAL_SPEED
		$walksidewalk.play(0)
		$walkgrass.stop()

# Slow down Teddy when he's in grass areas
func _on_Teddy_enters_grass(body):
	if body.name == "Street_Teddy":
		Global.Teddy_Speed = Global.GRASS_SPEED
		$walkgrass.play(0)
		$walksidewalk.stop()


# when teddy walks in area behind tombstones, move tombstones forward
func _teddy_behind_tombstones(body):
	$Scenery.z_index = 1


# when teddy leaves area behind tombstones, move tombstones back
func _teddy_not_behind_tombstones(body):
	$Scenery.z_index = 0


func _on_settings_pressed():
	$OptionsMenu.visible = true # Replace with function body.
