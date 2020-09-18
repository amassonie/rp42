extends KinematicBody2D

var MAX_SPEED = 0

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var movement = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = input_vector
	else:
		velocity = Vector2.ZERO
		animationState.travel("Idle")
	movement = velocity * MAX_SPEED
	velocity = move_and_slide(velocity * MAX_SPEED)

func set_maxspeed(value):
	MAX_SPEED += value

func _ready():
	set_maxspeed(450)
