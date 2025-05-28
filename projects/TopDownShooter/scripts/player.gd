extends CharacterBody2D

# https://www.youtube.com/watch?v=HycyFNQfqI0&list=PLRUAyEKP_aRche88xW0J-X3lpPHPDeCRm

@export var movespeed = 400 # move speed in pixels/sec
@export var rotation_speed = 5.5 # turning speed in radians/sec


#func _physics_process(delta: float) -> void:
	#var move_input = Input.get_axis("down", "up")
	#var rotation_direction = Input.get_axis("left", "right")
	#
	#velocity = transform.x * move_input * movespeed
	#rotation += rotation_direction * rotation_speed * delta
#
	#move_and_slide()
	#look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	
	motion = motion.normalized()
	velocity = motion * movespeed

	move_and_slide()
	look_at(get_global_mouse_position())
