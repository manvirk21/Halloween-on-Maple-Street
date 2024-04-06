extends Node2D

@export var scenes: Array[PackedScene] = []

func _on_timer_timeout():
	var scene_instance = scenes.pick_random().instantiate()
	add_child(scene_instance)
