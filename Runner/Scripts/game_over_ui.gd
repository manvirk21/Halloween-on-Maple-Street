extends Control


func _ready():
	Signals.connect("killplayer", gameover)

func gameover():
	get_tree().change_scene_to_file("res://Scenes/UI/game_over_ui.tscn")

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

#func _on_exit_pressed():
	#get_tree().change_scene_to_file("MAIN GAME SCENE FILE")
