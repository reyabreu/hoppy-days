extends AnimatedSprite

var anim

func update(motion):
	var new_anim
	
	if motion.y < 0:
		new_anim = "jump"
		flip_h = false
	elif abs(motion.x) > 0:
		new_anim = "move"
		flip_h = motion.x < 0
	else:
		new_anim = "idle"
		flip_h = false
	
	if new_anim != anim:
		anim = new_anim
		play(anim)
