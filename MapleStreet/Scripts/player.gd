extends CharacterBody2D

 
const SPEED = 200.0


func _physics_process(_delta):
	_process_user_input()

	move_and_slide()


func _process_user_input():
	var direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	velocity = SPEED * direction
	
