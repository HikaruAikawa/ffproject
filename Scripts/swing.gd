extends Node2D

#The user of this swing
var user
#Timers for the swing
var swing_timer
var swing_time
#The hitbox for this swing, and its size
var hitbox
var size
#Angle of the swing (from the cardinal direction; the total angle will be this times two)
var angle
#The sprite of the weapon that will be swung, and its texture
var sprite
var texture

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

func initialize(usr,tex,sw_time,ang,sz):
	user = usr
	texture = tex
	swing_time = sw_time
	angle = ang
	size = sz

func _process(delta):
	if(!hitbox.get_overlapping_areas().empty()):
		print("Test")