extends Area2D
var move = 8
var left_right = true
var pin_status = 0 # 0: up, 1: left, 2: right, 3: strike

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
		if(position.y >= 98):
			roll()
		else:
			$AnimatedSprite2D.stop()
			visible = false
			knock_pins()
	
	if Input.is_action_pressed("ui_accept"):
		left_right = false
		
func roll():
	$AnimatedSprite2D.play("roll")
	position.y += -6
	
func reset():
	$"../pins_Some".flip_v = false
	$"../pins_Some".visible = false
	$"../pins_Strike".visible = false
	position.x = 420
	position.y = 700
	visible = true
	left_right = true
	pin_status = 0

func knock_pins():
	if pin_status == 0: #miss
		print("miss")
	else:
		$"../Crash".visible = true
		$"../CrashTimer".start()
		$"../CycleTimer".start()
		$"../pins_Up".visible = false
		if pin_status == 3:
			$"../pins_Strike".visible = true
		elif pin_status == 1:
			$"../pins_Some".flip_v = true
			$"../pins_Some".visible = true
		elif pin_status == 2:
			$"../pins_Some".visible = true

func _on_strike_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("strike")
	pin_status = 3
	
	

func _on_some_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("some")
	if position.y > 1250:
		pin_status = 2 #right
	else:
		pin_status = 1 #left
	


func _on_crash_timer_timeout():
	print("crash timer over")
	$"../Crash".visible = false


func _on_cycle_timer_timeout():
	print("cycle timer over")
	reset()
