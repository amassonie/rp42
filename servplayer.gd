extends KinematicBody2D

var MAX_SPEED = 450

var dest_vector = Vector2.ZERO    


onready var servPlayer = get_node(".")

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var dest = Vector2.ZERO

func set_dest(x, y):
	dest.x = x
	dest.y = y

func _physics_process(delta):
	dest_vector = (dest - servPlayer.position)
	dest_vector = dest_vector.normalized()
	if dest_vector != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", dest_vector)
		animationTree.set("parameters/walk/blend_position", dest_vector)
		animationState.travel("walk")
	else:
		animationState.travel("idle")
	#move_and_slide(dest_vector * min(MAX_SPEED, (dest - servPlayer.position).length() / delta))
	
	#if ((dest - servPlayer.position).length()) == 0:
		#dest = get_node("../player").position

func _ready():
	set_dest(150, 20)
	
