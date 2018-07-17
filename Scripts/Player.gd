extends KinematicBody2D

const SPEED = 750 # pixels/s
const GRAVITY_FORCE = 3600 # pixels/s^2 
const FLOOR_NORMAL = Vector2(0, -1) # pointing upwards
const JUMP_SPEED = 1750

var motion = Vector2()

func _physics_process(delta):
	update_motion(delta)

func _process(delta):
	update_animation()

func update_motion(delta):
	fall(delta)
	jump()
	move_and_slide(motion, FLOOR_NORMAL)
	move()
		
func fall(delta):
	motion.y = 0 if is_on_floor() or is_on_ceiling() else motion.y + (GRAVITY_FORCE * delta)
	
func move():
	# capture user input	
	var move_right = Input.is_action_pressed("ui_right")
	var move_left = Input.is_action_pressed("ui_left")

	var target_speed = Vector2()
	# set motion with speed
	if move_right and not move_left:
		target_speed.x += 1
	elif move_left and not move_right:
		target_speed.x -= 1

	target_speed *= SPEED 
	motion.x = lerp(motion.x, target_speed.x, 0.1)
	if (is_on_floor() or is_on_ceiling()) and abs(motion.x - target_speed.x) <= 40:
		motion.x = target_speed.x
	
func jump():
	# capture user input	
	var jump = Input.is_action_pressed("ui_jump")
	
	if is_on_floor() and jump:
		motion.y = -JUMP_SPEED	

func update_animation():
	$AnimatedSprite.update(motion)
