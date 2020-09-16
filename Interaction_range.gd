extends Area2D

var is_movable = 0
var is_grab = 0
var timer = 0
var grabbed_body = null

func _on_Interaction_range_body_entered(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0:
		is_movable = 1
		grabbed_body = body

func _on_Interaction_range_body_exited(body):
	if body.get_parent().get_name() == "movable_object" && is_grab == 0:
		is_movable = 0

func move_obj():
	var obj = get_node(grabbed_body.get_path())
	

func _process(delta):
	timer += delta
	if is_movable == 1:
		if (Input.is_action_pressed("grab_obj") && is_grab == 0 && timer > 0.2):
			is_grab = 1
			timer = 0
			print("grabbed")
		elif (Input.is_action_pressed("grab_obj") && is_grab == 1 && timer > 0.2):
			is_grab = 0
			timer = 0
			print("not grabbed")
		if is_grab:
			move_obj()
