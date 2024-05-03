extends Area2D
var move = 8
var left_right = true
var pin_status = 0 # 0: up, 1: left, 2: right, 3: strike
var strike_count = 0
var sound_has_played = false

# Resize variables
var far_y = 0
var near_y = 840
var max_scale : float = 1.1
var min_scale : float = max_scale * (1.8/3.0)

var give_candy : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	left_right == true
	$"../../FinishScreen".visible = false
	#$AnimatedSprite2D.set_animation("rest")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	resize()
	if(left_right):
		position.x += move
		if(position.x == 740):
			move = move * -1
		elif(position.x == 100):
			move = move * -1
	else:
		if(pin_status == 3):
			if(position.y >= 250):
				roll()
			else:
				$AnimatedSprite2D.stop()
				visible = false
				knock_pins()
		else:
			if(position.y >= 180):
				roll()
				if !sound_has_played:
					sound_has_played = true
					$Roll.play(0)
			else:
				$AnimatedSprite2D.stop()
				visible = false
				knock_pins()
			
	
	if Input.is_action_pressed("ui_accept"):
		left_right = false
		
		
func roll():
	$AnimatedSprite2D.play("roll")
	position.y += -5
	
func reset():
	position.x = 420
	position.y = 700
	visible = true
	left_right = true
	pin_status = 0


func knock_pins():
	if pin_status == 0: #miss
		print("knock pins miss")
		reset()
	else:
		$"../Crash".visible = true
		$"../pins_Up".visible = false
		if pin_status == 3:
			$"../pins_Strike".visible = true
		elif pin_status == 1: #left
			$"../pins_Some_Left".visible = true
		elif pin_status == 2: #right
			$"../pins_Some_Right".visible = true
		await get_tree().create_timer(1).timeout
		$"../Crash".visible = false
		await get_tree().create_timer(1).timeout
		bear_reset()
		await get_tree().create_timer(1).timeout
		reset()
		

func bear_reset():
	$"../bear".visible = true
	await get_tree().create_timer(3).timeout
	$"../pins_Some_Right".visible = false
	$"../pins_Some_Left".visible = false
	$"../pins_Strike".visible = false
	$"../pins_Up".visible = true
	await get_tree().create_timer(2).timeout
	$"../bear".visible = false
	if(strike_count >= 3):
		give_candy = true
		Global.change_to_main_street("bowling", give_candy)

	
func _on_strike_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("strike")
	$"../../CrashSound".play(0)
	pin_status = 3
	strike_count += 1


func _on_some_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("some")
	$"../../CrashSound".play(0)
	if position.x > 420:
		print("right")
		pin_status = 2 #right
	else:
		print("left")
		pin_status = 1 #left


func _on_miss_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("collision miss")
	pin_status = 0

func resize():
	var distance = (position.y - far_y) / near_y
	scale.x = lerp(min_scale, max_scale, distance)
	scale.y = lerp(min_scale, max_scale, distance)
