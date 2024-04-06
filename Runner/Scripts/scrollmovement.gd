extends Node2D

@export var scroll_speed = 8

func move():
	position.x -= scroll_speed
