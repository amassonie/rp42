extends Area2D

var nb_obj_set = 0
onready var timer = 0

func _on_launchpad_body_entered(body):
	body.player.get_child(5).set_grab(0)
	body.player.set_maxspeed(100)
	nb_obj_set += 1
	self.get_child(2).set_value(nb_obj_set)
	print(nb_obj_set)
	get_node(body.get_path()).queue_free()
	if (nb_obj_set == 17):
		print("Nice duck win")

func _process(delta):
	timer += delta
	if timer > 600:
		print("Bad duck win")
