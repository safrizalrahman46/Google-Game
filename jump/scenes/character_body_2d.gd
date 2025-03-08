extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1900

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
			#$JumpSound.play()
		elif Input.is_action_just_pressed("ui_down"):
			$AnimatedSprite2D.play("duck")
			$runcool.disabled = true
		else:
			$AnimatedSprite2D.play("run")
	#else:
		#$AnimatedSprite2D.play("jump")
		
	move_and_slide()
