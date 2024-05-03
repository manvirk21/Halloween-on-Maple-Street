extends Control


func _on_start_button_pressed():
	print(Save.is_intro_viewed())
	if Save.is_intro_viewed():
		get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")
		return
	else:
		get_tree().change_scene_to_file("res://intro_outro/Scenes/intro_outro.tscn")
		return


func _on_settings_pressed():
	$ResetWindow.visible = true


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits/scenes/credits.tscn")


func _on_no_pressed():
	$ResetWindow.visible = false


func _on_yes_pressed():
	Save.reset()
	$ResetWindow.visible = false
