extends KinematicBody2D

var speed : int = 200
var velocity : Vector2 = Vector2()

onready var sprite : Sprite = get_node("sprite")

func _physics_process(delta):
	
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.x < 0:
		sprite.flip_h = false
	elif velocity.x > 0:
		sprite.flip_h = true
