extends "res://Scripts/skill.gd"

var target

func _init():
	mp_cost = 20
	cooldown = 2
	
	target = Area2D.new()
	add_child(target)
	target.set_owner(self)
#	
	var rect = RectangleShape2D.new()
	rect.set_extents(Vector2(15,15))
	target.add_shape(rect)
	target.set_shape_as_trigger(0,true)

func _process(delta):
	target.set_pos(96*user.get_forward())

func effect():
	if(target.get_overlapping_bodies().empty()):
		user.set_global_pos(target.get_global_pos())
		return true
	else:
		print("Imposible teleportar")
		return false
