extends Area2D
var move = 8
var left_right = true

# Called when the node enters the scene tree for the first time.
func _ready():
	left_right == true
	#$AnimatedSprite2D.set_animation("rest")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(left_right):
		position.x += move
		if(position.x == 740):
			move = move * -1
		elif(position.x == 100):
			move = move * -1
	else:
		if(position.y >= 100):
			roll()
		else:
			$AnimatedSprite2D.stop()
			visible = false
			reset()
	
	if Input.is_action_pressed("ui_accept"):
		left_right = false
		
func roll():
	$AnimatedSprite2D.play("roll")
	position.y += -6
	
func reset():
	position.x = 420
	position.y = 700
	visible = true
	left_right = true

func _on_strike_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("strike")
	
	

func _on_some_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("some")
