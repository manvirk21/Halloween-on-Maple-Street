extends Control


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_continue_pressed():
	get_tree().paused = false
