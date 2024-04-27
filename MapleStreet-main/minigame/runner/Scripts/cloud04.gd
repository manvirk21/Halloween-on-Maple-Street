extends "res://minigame/runner/Scripts/scrollmovement.gd"

func _physics_process(delta):
	move()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
