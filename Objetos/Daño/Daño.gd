extends Area2D

signal hit
signal hitClone(clone)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("hit")
	if body.is_in_group("clonColision"):
		emit_signal("hitClone",body.get_parent())
	elif (body.is_in_group("clon")):
		emit_signal("hitClone",body)
		

