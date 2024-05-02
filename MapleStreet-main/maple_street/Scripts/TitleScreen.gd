extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")


func _on_settings_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits/scenes/credits.tscn")
