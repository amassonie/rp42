extends KinematicBody2D


var is_in_range = 0
var is_grabbed = 0
var timer = 0
var player_size = Vector2.ZERO
var obj_size = Vector2.ZERO

onready var obj = get_node(".")
var player = null

func get_player_size():
	player_size.x = player.get_child(0).texture.get_size().x / player.get_child(0).hframes
	player_size.y = player.get_child(0).texture.get_size().y / player.get_child(0).vframes
	player_size.x *= player.scale.x
	player_size.y *= player.scale.y

func get_obj_size():
	obj_size = get_child(0).texture.get_size() * obj.scale

func is_in_range(body, value):
	player = body
	get_player_size()
	is_in_range = value

func move_obj():
	var orientation = player.input_vector.angle() * 180 / PI
	if orientation >= -46 && orientation <= 46 && Input.is_action_pressed("move_right"):
		obj.position.x = player.position.x + player_size.x / 5.7 + obj_size.x / 2
		obj.position.y = player.position.y
	elif orientation >= 134 || orientation <= -134:
		obj.position.x = player.position.x - player_size.x / 5.7 - obj_size.x / 2
		obj.position.y = player.position.y
	elif orientation > 45 && orientation < 135:
		obj.position.x = player.position.x 
		obj.position.y = player.position.y + player_size.y / 5.7 + obj_size.y / 2 + 7 * player.scale.y
	elif orientation > -135 && orientation < -45:
		obj.position.x = player.position.x 
		obj.position.y = player.position.y - player_size.y / 5.7 - obj_size.y / 2 + 7 * player.scale.y
	move_and_slide(player.movement)

func _process(delta):
	timer += delta
	if is_in_range:
		if Input.is_action_pressed("grab_obj") && !is_grabbed && timer > 0.3:
			is_grabbed = 1
			player.get_child(5).set_grab(1)
			player.set_maxspeed(-100)
			timer = 0
			print("grabbed")
		elif Input.is_action_pressed("grab_obj") && is_grabbed && timer > 0.3:
			is_grabbed = 0
			player.get_child(5).set_grab(0)
			player.set_maxspeed(100)
			timer = 0
			print("not grabbed")
	if is_grabbed:
		move_obj()

func _ready():
	get_obj_size()
