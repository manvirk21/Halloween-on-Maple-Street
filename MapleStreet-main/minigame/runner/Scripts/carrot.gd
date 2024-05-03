extends "res://minigame/runner/Scripts/scrollmovement.gd"
@onready var optionsbutton: AudioStreamPlayer2D = get_node("res://minigame/runner/Scenes/UI/runner.tscn")
func _physics_process(delta):
	move()

func _on_pickup_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("rewardplayer", 1)
		
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
