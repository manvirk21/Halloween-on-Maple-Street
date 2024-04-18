extends Node2D

@onready var Cheese: Sprite2D = find_child("CheeseSprite") 

func _on_pickup_body_entered(_body):
	Cheese.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
