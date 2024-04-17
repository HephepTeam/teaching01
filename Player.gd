extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	
	# get the direction vector (Vector2) representing the direction the character is going
	# according to the inputs (here the keyboard)
	var direction = Input.get_vector("ui_left", "ui_right","ui_up", "ui_down" )
	
	#direction is a vector: we get the angle from the vector (1,0) (right direction) in radians
	var angle = direction.angle()
	# translating radians to degrees
	var angle_degrees = rad_to_deg(angle)
	# snapping the value to fixed values representing our directions (so even with joystick it's ok
	# and each direction is a number from 0 to 7 since we divide the angle by 45 degrees

	var a = snapped(angle_degrees, 45) / 45
	# need to keep the value in a specific range so if it overflow from one side it comes back to another
	a = wrapi(int(a), 0, 8)
	
	
	# calling the moving animation corresponding to the direction's number (moving0, moving1...)
	$AnimatedSprite2D.play("moving"+str(a))
	# depending on the direction on the x axis, flip the sprite or not ( trick to use if you don't 
	# have all the frames but only one side)
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	

	# direction is not (0,0) so apply velocity to the characterbody2D
	if direction:
		velocity = direction * SPEED
	else: #direction is 0,0) so gradually reduce the velocity to stop the character
		velocity = velocity.move_toward(Vector2(0,0), SPEED)
	
	# characterbody2D needs to call this function in order for their velocity to be processed 
	# by the physics engine
	move_and_slide()
