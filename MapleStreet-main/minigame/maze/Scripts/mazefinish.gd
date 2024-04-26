extends Node2D

@onready var Congrats: Sprite2D = get_node("MiniGameFinish/FinishScreen") #set variable Congrats for the FinishScreen Sprite2D
@onready var Cheese: Sprite2D = get_node("../Cheese/CheeseSprite") 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#when teddy finishes the maze the finish screen becomes visible
func _on_finish_area_2d_body_entered(body):
	if Cheese.visible == false:
		Congrats.visible = true 
	else:
		pass
