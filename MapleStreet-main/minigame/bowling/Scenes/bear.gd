extends Sprite2D
var goin = true
var goout = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(visible == true):
		move()
	else:
		goin = true
		position.x = 1550
	
func move():
	if(goin and position.x > 500):
		position.x -= 5
	elif(goin and position.x <= 500):
		goout = true
		goin = false
	if(goout and position.x < 1500):
		position.x += 6
	elif(goout and position.x >= 1500):
		goout = false
