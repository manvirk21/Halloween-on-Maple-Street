extends Control


func _ready():
	Signals.connect("killplayer", gameover)

func gameover():
	get_tree().change_scene_to_file("res://minigame/runner/Scenes/UI/game_over_ui.tscn")

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://minigame/runner/Scenes/runner.tscn")

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")
