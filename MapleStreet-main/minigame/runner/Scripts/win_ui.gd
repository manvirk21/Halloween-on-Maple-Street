extends Control


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://minigame/runner/Scenes/runner.tscn")


func _on_continue_pressed():
	get_tree().paused = false
