extends Area2D

var is_movable = 0
var is_grab = 0
var timer = 0
var grabbed_body = null
var player_size = Vector2.ZERO
var obj
var obj_size

onready var player = get_node("..")

func get_player_size():
	player_size.x = get_node("../sprite").texture.get_size().x / get_node("../sprite").hframes
	player_size.y = get_node("../sprite").texture.get_size().y / get_node("../sprite").vframes
	player_size.x *= player.scale.x
	player_size.y *= player.scale.y

func get_obj_size():
	obj = get_node(grabbed_body.get_path())
	obj_size = obj.get_children()[0].texture.get_size() * obj.scale

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
	obj.move_and_slide(player.movement)


func _on_Interaction_range_body_entered(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0:
		is_movable = 1
		grabbed_body = body
		get_obj_size()

func _on_Interaction_range_body_exited(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0:
		is_movable = 0

func _process(delta):
	timer += delta
	if is_movable == 1:
		if (Input.is_action_pressed("grab_obj") && is_grab == 0 && timer > 0.3):
			is_grab = 1
			player.set_maxspeed(-100)
			timer = 0
			print("grabbed")
		elif (Input.is_action_pressed("grab_obj") && is_grab == 1 && timer > 0.3):
			is_grab = 0
			player.set_maxspeed(100)
			timer = 0
			print("not grabbed")
		if is_grab:
			move_obj()

func _ready():
	get_player_size()
