extends KinematicBody2D

var MAX_SPEED = 300

var velocity = Vector2.ZERO

onready var sprite : Sprite = get_node("sprite")

func _physics_process(delta):
	var input_vector = Vector2.ZERO    
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = input_vector
	else:
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity * MAX_SPEED)
	
	if velocity.x < 0:
		sprite.flip_h = false
	elif velocity.x > 0:
		sprite.flip_h = true
