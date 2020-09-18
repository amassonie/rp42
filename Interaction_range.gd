extends Area2D

var is_grab = 0
var is_killable = 0

var timerk = 0
var grabbed_body = null
var kill_body = null

onready var player = get_node("..")

func set_grab(value):
	is_grab = value

func _on_Interaction_range_body_entered(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0 && body.is_in_range == 0:
		body.is_in_range(player, 1)
	elif body.get_parent().get_name() == "servPlayer" && body.name != "player":
		is_killable = 1
		kill_body = get_node(body.get_path())

func _on_Interaction_range_body_exited(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0:
		body.is_in_range(player, 0)
	elif body.get_parent().get_name() == "servPlayer":
		is_killable = 0

func _process(delta):
	timerk += delta
	if is_killable == 1 && Input.is_action_pressed("kill") && timerk > 5:
		timerk = 0
		kill_body.queue_free()
