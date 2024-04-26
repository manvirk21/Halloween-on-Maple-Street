extends Node2D


var trash_positions = {
	"left": Vector2(1113, 626),
	"middle": Vector2(1372, 626),
	"right": Vector2(1632, 626)
}


var candy_positions = {
	"left": Vector2(1000, 526),
	"middle": Vector2(1260, 526),
	"right": Vector2(1520, 526)
}

var trash_cans = {}
var candy = {}

func _ready():
	trash_cans["left"] = $Trash1
	trash_cans["middle"] = $Trash2
	trash_cans["right"] = $Trash3
	candy["left"] = $Cotton
	candy["middle"] = $Cotton2
	candy["right"] = $Cotton3

func _on_PlayButton_pressed():
	$PlayButton.visible = false
	$ExitGame.visible=false
	candy["left"].visible = false
	candy["middle"].visible = false
	candy["right"].visible = false
	await timer(2)
	var random_position = ["left", "middle", "right"][randi() % 3]
	candy[random_position].visible = true
	await timer(1)
	slide_trash_down()
	await timer(1)
	for i in range(20):
		swap_trash_cans_and_candy()
		await timer(0.6)



func timer(delay: float) -> void:
	await get_tree().create_timer(delay).timeout
	
	
func slide_trash_down():
	var tween = create_tween()
	
	tween.parallel().tween_property($Trash1, "position", $Trash1.position + Vector2(0, 225), 0.3)
	tween.parallel().tween_property($Trash2, "position", $Trash2.position + Vector2(0, 225), 0.3)
	tween.parallel().tween_property($Trash3, "position", $Trash3.position + Vector2(0, 225), 0.3)
	

	
func slide_trash_up():
	var tween = create_tween()
	
	tween.tween_property($Trash1, "position", $Trash1.position + Vector2(0, -225), 0.3)
	tween.tween_property($Trash2, "position", $Trash2.position + Vector2(0, -225), 0.3)
	tween.tween_property($Trash3, "position", $Trash3.position + Vector2(0, -225), 0.3)

	
func swap_trash_cans_and_candy():
	var tween = create_tween()


	var positions = ["left", "middle", "right"]
	var index = randi() % 3
	
	var first_position = positions[index]
	var second_position = positions[(index + 1) % 3]
		
	if first_position in trash_cans and second_position in trash_cans:
		tween.parallel().tween_property(trash_cans[first_position], "position", trash_positions[second_position], 0.5) 
		tween.parallel().tween_property(trash_cans[second_position], "position", trash_positions[first_position], 0.5)
		tween.parallel().tween_property(candy[first_position], "position", candy_positions[second_position], 0.5)
		tween.parallel().tween_property(candy[second_position], "position", candy_positions[first_position], 0.5)

		var temp = trash_cans[first_position]
		var temp2 = candy[first_position]
		trash_cans[first_position] = trash_cans[second_position]
		candy[first_position] = candy[second_position]
		trash_cans[second_position] = temp
		candy[second_position] = temp2
		
		
	else:
		print("Error: One or both trash cans not found in dictionary.")
	

	


func _on_trash_1_pressed():
	var trash_position = check_position($Trash1)
	print(trash_position)
	check_win(trash_position)
	await timer(1)
	slide_trash_up()

func _on_trash_2_pressed():
	var trash_position = check_position($Trash2)
	print(trash_position)
	check_win(trash_position)
	await timer(1)
	slide_trash_up()


func _on_trash_3_pressed():
	var trash_position = check_position($Trash3)
	print(trash_position)
	check_win(trash_position)
	await timer(1)
	slide_trash_up()
	
	
func check_position(trash: Button) -> String:
	var position = trash.position
	print(trash.position)
	var trash_position = ""
	if position == Vector2(1113, 626):
		trash_position = "left"
	elif position == Vector2(1372, 626):
		trash_position = "middle"
	elif position == Vector2(1632, 626):
		trash_position = "right"
	print(trash_position)
	return trash_position



func check_win(trash_position: String):
	print("Trash position:", trash_position)
	if trash_position in candy and candy[trash_position].visible:
		print("You won!")
		$YouWin.visible = true
		await timer(5)
		$PlayButton.visible = true
		$YouWin.visible = false
		$ExitGame.visible=true
		# Show "You won!" text or perform other win actions
	else:
		print("Try again")
		$Retry.visible = true
		$ExitGame.visible=true
		# Show "Try again" text or perform other lose actions




func _on_retry_pressed():
	_on_PlayButton_pressed()
	$Retry.visible = false
	$ExitGame.visible=false


func _on_exit_game_pressed():
	$ExitGame.visible = false
	get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")
	# Replace with function body.
