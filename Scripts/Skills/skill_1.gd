extends "res://Scripts/skill.gd"

var target
var game_area

#CLASS METHODS

static func get_skill_name(): return "Teleport"
static func get_mp_cost(): return 20
static func get_cooldown(): return 2

#OTHER METHODS

func _ready():
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
	
	target.set_layer_mask_bit(cons.LYB_DEFAULT,false)
	target.set_collision_mask_bit(cons.LYB_GAME_AREA,true)
	
	game_area = get_node("/root/Main/Map/GameArea")

func _process(delta):
	target.set_pos(96*user.get_forward())

func effect():
	if(target.get_overlapping_bodies().empty() && target.overlaps_area(game_area)):
		user.set_global_pos(target.get_global_pos())
		return true
	else:
		#print("Can't teleport")
		return false
