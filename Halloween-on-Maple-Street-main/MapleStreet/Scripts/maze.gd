extends Node2D

@export var MapleStreet : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	set_Teddy_settings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Go back to Maple Street Scene
	if Input.is_action_just_pressed("X"):
		get_tree().change_scene_to_packed(MapleStreet)

# Set Teddy resize and sprite flip
func set_Teddy_settings():
	var Teddy_resize = false
	var Teddy_sprite_flip = false
	
	Global.set_Teddy_settings(Teddy_resize, Teddy_sprite_flip)
