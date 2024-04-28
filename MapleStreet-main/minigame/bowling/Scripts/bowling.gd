extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _on_button_pressed(): # code for testing button, left minigame
	get_tree().change_scene_to_file("res://maple_street/Scenes/Maple_Street.tscn")
