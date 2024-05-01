extends Control

var give_candy : bool = false

func _ready():
	Signals.connect("killplayer", gameover)

func gameover():
	give_candy = true
	Global.change_to_main_street("runner", give_candy)

#func _on_restart_pressed():
	#get_tree().change_scene_to_file("res://minigame/runner/Scenes/runner.tscn")
#
#func _on_exit_pressed():
	#get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")
