extends CharacterBody2D

# Speed
const SPEED : float = 275

# Resize variables
var far_y = 0
var near_y = 1080
var max_scale : float = 1.1
var min_scale : float = 0.45


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_process_user_input()
	resize_Teddy()
	flip_Teddy()
	move_and_slide()


# Process user input
func _process_user_input():
	var direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	velocity = SPEED * direction
	
	
# Flip sprite, if applicable
func flip_Teddy():
	if Global.Teddy_sprite_flip_on:
		var sprite = get_node("Teddy_Sprite")
		
		# moving left
		if velocity.x < 0:
			sprite.flip_h = true
			
		# moving right
		elif velocity.x > 0:
			sprite.flip_h = false


# Resize Teddy, if applicable
func resize_Teddy():
	if Global.Teddy_resize_on:
		var distance = (position.y - far_y) / near_y
		scale.x = lerp(min_scale, max_scale, distance)
		scale.y = lerp(min_scale, max_scale, distance)


func _on_finish_area_2d_body_entered(body):
	pass # Replace with function body.
