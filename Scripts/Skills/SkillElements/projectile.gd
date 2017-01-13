extends "res://Scripts/animated_entity.gd"

var hitbox

func _ready():
	movement_speed = 1
	set_state(ST_MOVING)
	sprite = Sprite.new()
	add_child(sprite)
	sprite.set_hframes(3)
	sprite.set_vframes(1)
	hitbox = Area2D.new()
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(12,12))
	hitbox.add_shape(shape)

func _process():
	if (!hitbox.get_overlapping_areas().empty()):
		self.queue_free()

func init_animations():
	animations = {
		ST_IDLE : {
			DR_UP:		[[0,1,2],[5,5,5]],
			DR_LEFT:	[[0,1,2],[5,5,5]],
			DR_DOWN:	[[0,1,2],[5,5,5]],
			DR_RIGHT:	[[0,1,2],[5,5,5]]
		},
		ST_MOVING : {
			DR_UP:		[[0,1,2],[5,5,5]],
			DR_LEFT:	[[0,1,2],[5,5,5]],
			DR_DOWN:	[[0,1,2],[5,5,5]],
			DR_RIGHT:	[[0,1,2],[5,5,5]]
		}
	}
	set_animation()

func set_texture(texture):
	sprite.set_texture(texture)