extends KinematicBody2D

onready var ground_check = $ground_check
onready var anim = $anim
var velocity = Vector2.ZERO
var move_speed = 240
var gravity = 20
var jump_force = -500
var is_grounded = true
enum {RUN, IDLE, GOING_UP, FALL}
var animState = RUN
var is_do_jump = false

func _physics_process(delta):
	# Gravity and running
	velocity.y += gravity
	velocity.x = move_speed
	if is_do_jump:
		velocity.y = jump_force
		is_do_jump = false
	velocity = move_and_slide(velocity)

func _process(delta):
	_check_state()
	pass

func _input(event):
	if event.is_action_pressed("jump") and is_grounded:
		ground_check.set_enabled(false)
		anim.play("jump")
		anim.queue("fall")
		yield(get_tree().create_timer(.4), "timeout")
		ground_check.set_enabled(true)
		
		

func jump():
	is_do_jump = true

func _check_state():
	if ground_check.is_colliding():
		is_grounded = true
		anim.play("run")
	else:
		is_grounded = false
	

