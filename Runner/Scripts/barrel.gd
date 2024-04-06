extends "res://Scripts/scrollmovement.gd"

func _physics_process(delta):
	move()


func _on_effect_damage_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("killplayer")
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
