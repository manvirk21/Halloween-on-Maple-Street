extends CharacterBody2D

var vel = Vector2.ZERO

@export var jump_vel = 740.0
@export var gravity_scale = 25.0

var score = 0
var give_candy : bool = false


enum {
	JUMP,
	RUN,
	IDLE
}

var state = RUN

@onready var animation = $AnimatedSprite2D

func _ready():
	Signals.connect("rewardplayer", rewardplayer)
	Signals.connect("killplayer", killplayer)

func _physics_process(delta):
	match state:
		RUN:
			animation.play("run")
		JUMP:
			vel = Vector2.ZERO
			vel.y -= jump_vel
			animation.play("jump")
			state = IDLE
		IDLE:
			pass
	vel.y += gravity_scale
	move_and_collide(vel * delta)
	
func _input(event):
	if state == RUN:
		if event.is_action_pressed("jump"):
			state = JUMP
			$jump.play(0)

func _on_area_2d_body_entered(body):
	if body is StaticBody2D:
		state = RUN

func _on_area_2d_body_exited(body):
	if body is StaticBody2D:
		state = JUMP

func rewardplayer(scoretoadd):
	score += scoretoadd
	Signals.emit_signal("updatescore", score)
	$collectcarrot.play(0)
	

func killplayer():
	queue_free()
	if score >= 12:
		give_candy = true
	else:
		give_candy = false
	Global.change_to_main_street("runner", give_candy)

