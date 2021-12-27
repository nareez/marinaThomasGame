extends KinematicBody2D

onready var ground_check = $ground_check
onready var anim = $anim
var velocity = Vector2.ZERO
var move_speed = 240
const MAX_MOVESPEED = 40000
var gravity = 20
var jump_force = -750
var is_grounded = true
enum {RUN, IDLE, GOING_UP, FALL}
var animState = RUN
var is_do_jump = false
var is_going_down = false

func _physics_process(delta):
	# Gravity and running
	velocity.y += gravity
	velocity.x = move_speed
	velocity = move_and_slide(velocity)

func _process(delta):
	_process_state()

func _input(event):
	if event.is_action_pressed("jump") and is_grounded:
		is_do_jump = true

func _process_state():
	if ground_check.is_colliding():
		is_grounded = true
		anim.play("run")
	else:
		is_grounded = false
		
	if is_do_jump and is_grounded:
		ground_check.set_enabled(false)
		is_do_jump = false
		velocity.y = jump_force
		anim.play("jump")
		anim.queue("going-up")
		yield(get_tree().create_timer(.3), "timeout")
		ground_check.set_enabled(true)
		
	if velocity.y > 0 and not is_grounded:
		anim.play("fall")




func _on_Timer_timeout():
	move_speed *= 1.3
	if move_speed > MAX_MOVESPEED:
		move_speed = MAX_MOVESPEED
