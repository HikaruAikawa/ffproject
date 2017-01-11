extends Node2D

#DEFINITION OF CONSTANTS

const ST_IDLE = 0
const ST_MOVING = 1
const ST_HURT = 2
const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3

#DEFINITION OF VARIABLES

#The user of this swing
var user
#Timers for the swing
var swing_timer
var swing_time
#The hitbox for this swing, and its size
var hitbox
var size
#Angle of the swing
var angle
#The sprite of the weapon that will be swung, and its texture
var sprite
var texture

#DEFINITION OF METHODS

func is_player(): return false
func is_enemy(): return false

func _ready():
	set_global_pos(user.get_global_pos())
	sprite = find_node("Sprite")
	swing_timer = swing_time
	#The sprite gets positioned with origin at the bottom left
	sprite.set_offset(Vector2(0,-texture.get_height()))
	#The hitbox is positioned over the sprite (just trust me on this one)
	hitbox = find_node("Hitbox")
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(size/sqrt(2),10))
	hitbox.add_shape(shape,Matrix32(45,Vector2(size/2,-size/2)))
	#Gets positioned according to the user's current direction
	if (user.get_direction() == DR_RIGHT):
		rotate(-PI/2)
	elif (user.get_direction() == DR_LEFT):
		rotate(PI/2)
	elif (user.get_direction() == DR_DOWN):
		rotate(PI)
	elif (user.get_direction() == DR_UP):
		sprite.set_z(-1)
	translate(10*user.forward)
	rotate(-angle/2)
	set_process(true)

func initialize(usr,tex,sw_time,ang,sz):
	user = usr
	texture = tex
	swing_time = sw_time
	angle = ang
	size = sz

func _process(delta):
	rotate(angle*delta/swing_time)
	var overlapping_areas = hitbox.get_overlapping_areas()
	if(!overlapping_areas.empty()):
		for hit in overlapping_areas:
			if (hit.get_layer_mask_bit(11)):
				hit.get_parent().take_damage(10,15*(hit.get_global_pos()-get_global_pos()).normalized())
	swing_timer -= delta
	if (swing_timer <= 0):
		self.free()
