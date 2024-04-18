extends Node2D

@export var MapleStreet : PackedScene
@onready var Cheese: Node2D = find_child("Cheese")
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	set_Teddy_settings()
	var rndX = rng.randi_range(741, 1396) #creating randoom x position for cheese, the numbers are the bounds of the maze
	var rndY = rng.randi_range(34, 724) #creating randoom y position for cheese, the numbers are the bounds of the maze
	Cheese.position = Vector2(rndX, rndY)


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
