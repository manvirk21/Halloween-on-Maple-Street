extends Node2D

var obstacle = preload("res://Scenes/Obstacles/barrel.tscn")

func _on_Timer_timeout():
	var obs = obstacle.instance()
	obs.position = Vector2(1000, 570)
	add_child(obs)
