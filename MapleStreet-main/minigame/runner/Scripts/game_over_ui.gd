extends Control

var give_candy : bool = false

func _ready():
	Signals.connect("killplayer", gameover)

func gameover():
	pass
