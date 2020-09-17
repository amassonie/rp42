extends Area2D

var nb_obj_set = 0

func _on_launchpad_body_entered(body):
	body.player.get_child(5).set_grab(0)
	body.player.set_maxspeed(100)
	print("object set")
	nb_obj_set += 1
	get_node(body.get_path()).queue_free()
