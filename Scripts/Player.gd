extends KinematicBody2D

onready var ground_check = $ground_check
onready var anim = $anim
var velocity = Vector2.ZERO
var move_speed = 120.0
const MAX_MOVESPEED = 40000
var move_speed_inc = 15.0
var gravity = 20
var jump_force = -600
var is_grounded = true
var is_do_jump = false
var is_going_down = false

func _physics_process(_delta):
	# Gravity and running
	velocity.y += gravity
	velocity.x = move_speed
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(_delta):
	_process_state()

func _input(event):
	if event.is_action_pressed("jump") and is_grounded:
		is_do_jump = true

func _process_state():
#	Ground state check
	if ground_check.is_colliding():
		is_grounded = true
		anim.play("run")
	else:
		is_grounded = false
		
#	process jump
	if is_do_jump and is_grounded:
		ground_check.set_enabled(false)
		is_do_jump = false
		velocity.y = jump_force
		anim.play("jump")
		anim.queue("going-up")
		yield(get_tree().create_timer(.3), "timeout")
		ground_check.set_enabled(true)
	
#	process fall state
	if velocity.y > 0 and not is_grounded:
		anim.play("fall")

# A cada passada de tempo aumenta a velocidade do personagem
func _on_Timer_timeout():
	var animSpeed = _getAnimationSpeed("run")
	move_speed += move_speed_inc
	animSpeed *= 1+(move_speed_inc / move_speed)
	print (move_speed_inc / move_speed)
	_setAnimationSpeed("run", animSpeed)
	
	if move_speed > MAX_MOVESPEED:
		move_speed = MAX_MOVESPEED
		

func _setAnimationSpeed(animName, animSpeed):
	var anim = _getAnimation(animName)
	var idx = anim.find_track("anim:playback_speed")
	anim.track_set_key_value(idx, 0, animSpeed)
	
func _getAnimationSpeed(animName):
	var anim = _getAnimation(animName)
	var idx = anim.find_track("anim:playback_speed")
	return anim.track_get_key_value(idx, 0)

func _getAnimation(animName):
	var runAnim = anim.get_animation(animName)
	return runAnim

func _died():
	_setAnimationSpeed("run", 0.5)
	get_tree().reload_current_scene()
# implementar após a morte
func _on_VisibilityNotifier2D_screen_exited():
	_died()


func _on_TextureButton_pressed():
	if is_grounded:
		is_do_jump = true
