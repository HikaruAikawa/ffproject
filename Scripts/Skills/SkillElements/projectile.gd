extends "res://Scripts/animated_entity.gd"

var hitbox

func _ready():
	movement_speed = 1
	set_state(cons.ST_MOVING)
	sprite.set_hframes(3)
	sprite.set_vframes(1)
	
	hitbox = Area2D.new()
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(8,8))
	hitbox.add_shape(shape)
	set_layer_mask_bit(cons.LYB_DEFAULT,false)
	hitbox.set_layer_mask_bit(cons.LYB_DEFAULT,false)
	hitbox.set_layer_mask_bit(cons.LYH_PLAYER_ATTACKS,true)
	hitbox.set_collision_mask_bit(cons.LYH_ENEMIES,true)
	hitbox.set_collision_mask_bit(cons.LYB_WALLS,true)
	add_child(hitbox)

func _process(delta):
	for hit in hitbox.get_overlapping_areas():
		if (hit.get_layer_mask_bit(cons.LYH_ENEMIES)):
			print("Enemy found")
			die()
	if (!hitbox.get_overlapping_bodies().empty()):
		print("Wall found")
		die()

func init_animations():
	animations = {
		cons.ST_IDLE : {
			cons.DR_UP:		[[0,1,2],[5,5,5]],
			cons.DR_LEFT:	[[0,1,2],[5,5,5]],
			cons.DR_DOWN:	[[0,1,2],[5,5,5]],
			cons.DR_RIGHT:	[[0,1,2],[5,5,5]]
		},
		cons.ST_MOVING : {
			cons.DR_UP:		[[0,1,2],[5,5,5]],
			cons.DR_LEFT:	[[0,1,2],[5,5,5]],
			cons.DR_DOWN:	[[0,1,2],[5,5,5]],
			cons.DR_RIGHT:	[[0,1,2],[5,5,5]]
		}
	}
	set_animation()

func set_texture(texture):
	sprite.set_texture(texture)

#func _draw():
#	var extents = hitbox.get_shape(0).get_extents()
#	var pos = (hitbox.get_global_pos()-get_global_pos())
#	var matrix = hitbox.get_shape_transform(0)
#	var rect = Rect2(-extents,extents*2)
#	var p1 = matrix.xform(rect.pos)
#	var p2 = matrix.xform(rect.end)
#	var p3 = matrix.xform(Vector2(rect.pos.x,rect.end.y))
#	var p4 = matrix.xform(Vector2(rect.end.x,rect.pos.y))
#	#draw_rect(rect,Color(1,1,1,1))
#	draw_circle(p1,2,Color(1,1,1,1))
#	draw_circle(p2,2,Color(1,1,1,1))
#	draw_circle(p3,2,Color(1,1,1,1))
#	draw_circle(p4,2,Color(1,1,1,1))

func die():
	self.queue_free()