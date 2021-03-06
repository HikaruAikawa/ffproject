extends Node2D

#DEFINITION OF VARIABLES

#The user of this swing
var user
#Timers for the swing
var swing_timer
var swing_time
var swing_start_time
var swing_end_time
#The hitbox for this swing, and its size
var hitbox
var size
#Angle of the swing
var angle
var target_angle
var starting_angle
#The sprite node of the weapon that will be swung, and its texture
var sprite
var texture
#The damage and knockback this swing will inflict
var damage
var knockback
#This indicates how much the swing should be displaced from the border of the user
var pullback

#DEFINITION OF METHODS

func is_player(): return false
func is_enemy(): return false

func _ready():
	
#	swing_timer = swing_time + swing_start_time
	
	#Positions itself in front of the user
#	set_global_pos(user.get_global_pos())
#	translate((16-pullback)*user.get_forward())
#	
#	sprite = Sprite.new()
#	sprite.set_name("Sprite")
#	sprite.set_texture(texture)
#	add_child(sprite)
	
	#The sprite gets positioned with origin at the bottom left
#	sprite.set_centered(false)
#	sprite.set_pos(Vector2(0,0))
#	sprite.edit_set_pivot(Vector2(0,-texture.get_height()))
	
	#The hitbox is positioned in front of the player, and rotated in accordance to the sprite
#	hitbox = Area2D.new()
#	hitbox.set_name("Hitbox")
#	add_child(hitbox)
#	hitbox.set_pos(Vector2(0,0))
#	var shape = RectangleShape2D.new()
#	shape.set_extents(Vector2(size/2,12))
#	hitbox.add_shape(shape,Matrix32(PI/4,Vector2((size-pullback)/2,(-size+pullback)/2)))
	
#	#Sets the correct collision mask
#	hitbox.set_collision_mask_bit(cons.LYB_DEFAULT,false)
#	#If the user is a player, attacks enemies
#	if (user.get_layer_mask_bit(cons.LYB_PLAYERS)):
#		hitbox.set_collision_mask_bit(cons.LYH_ENEMIES,true)
#	#If the user is an enemy, attacks players
#	elif (user.get_layer_mask_bit(cons.LYB_ENEMIES)):
#		hitbox.set_collision_mask_bit(cons.LYH_PLAYERS,true)
	
	#The sprite gets positioned according to the user's current direction
#	if (user.get_direction() == cons.DR_RIGHT):
#		rotate(-PI/2)
#	elif (user.get_direction() == cons.DR_LEFT):
#		rotate(PI/2)
#	elif (user.get_direction() == cons.DR_DOWN):
#		rotate(PI)
#	elif (user.get_direction() == cons.DR_UP):
#		set_z(-1)
#	rotate(PI/4)
#	starting_angle = get_rot() - starting_angle
#	target_angle = get_rot() - target_angle
#	set_rot(starting_angle)

	set_process(true)

func initialize(user,texture,swing_time,swing_start_time,swing_end_time,starting_angle,target_angle,size,damage,knockback,pullback):
	self.user = user
	self.texture = texture
	self.swing_time = swing_time
	self.swing_start_time = swing_start_time
	self.swing_end_time = swing_end_time
	self.starting_angle = starting_angle
	self.target_angle = target_angle
	self.size = size
	self.damage = damage
	self.knockback = knockback
	self.pullback = pullback

func set_user(user): self.user = user
func set_attack(damage,knockback):
	self.damage = damage
	self.knockback = knockback

func set_sprite(texture,center,distance):
	sprite = Sprite.new()
	sprite.set_name("Sprite")
	sprite.set_texture(texture)
	add_child(sprite)
	#The sprite gets positioned with origin at the bottom left
	sprite.set_centered(false)
	sprite.set_pos(center)
	sprite.edit_set_pivot(Vector2(distance/sqrt(2),-distance/sqrt(2)-texture.get_height()))

func set_hitbox(position,size):
	hitbox = Area2D.new()
	hitbox.set_name("Hitbox")
	add_child(hitbox)
	hitbox.set_pos(position)
	var shape = RectangleShape2D.new()
	shape.set_extents(size/2)
	hitbox.add_shape(shape)
	#Sets the correct collision mask
	hitbox.set_collision_mask_bit(cons.LYB_DEFAULT,false)
	#If the user is a player, attacks enemies
	if (user.get_layer_mask_bit(cons.LYB_PLAYERS)):
		hitbox.set_collision_mask_bit(cons.LYH_ENEMIES,true)
	#If the user is an enemy, attacks players
	elif (user.get_layer_mask_bit(cons.LYB_ENEMIES)):
		hitbox.set_collision_mask_bit(cons.LYH_PLAYERS,true)

func set_times(swing_time,swing_start_time,swing_end_time):
	self.swing_time = swing_time
	self.swing_start_time = swing_start_time
	self.swing_end_time = swing_end_time
	swing_timer = swing_time + swing_start_time

func set_angles(starting_angle,target_angle):
	self.starting_angle = starting_angle+PI/4
	self.target_angle = target_angle+PI/4

func _process(delta):
	#Decreases the timer
	swing_timer -= delta
	
	#If it's pointing up, sets its z so it appears under the player
	var rot = sprite.get_global_transform().get_rotation()
	if (rot >= -PI/4 && rot <= 3*PI/4):
		sprite.set_z(-1)
	else: sprite.set_z(1)
	
	if (swing_timer > swing_time):
		sprite.set_rot(starting_angle)
	elif (swing_timer < swing_time && swing_timer > 0):
		#Sets rotation between the starting angle and the target angle
		sprite.set_rot(lerp(starting_angle,target_angle,1-(swing_timer/swing_time)))
		#Deals damage to all hitboxes it finds
		var overlapping_areas = hitbox.get_overlapping_areas()
		if(!overlapping_areas.empty()):
			for hit in overlapping_areas:
				#If the hitbox belongs to an enemy...
				if (hit.get_layer_mask_bit(cons.LYH_ENEMIES)):
					hit.get_parent().take_damage(damage,knockback*(hit.get_global_pos()-get_global_pos()).normalized())
	#If the timer has finished, sets the rotation to the target
	elif (swing_timer < 0 && swing_timer > -swing_end_time):
		sprite.set_rot(target_angle)
	elif (swing_timer < -swing_end_time):
		get_parent().finished()

func get_timer(): return swing_timer

#func _draw():
#	var extents = hitbox.get_shape(0).get_extents()
#	var pos = (hitbox.get_global_pos()-get_global_pos())
#	var rect = Rect2(pos-extents,extents*2)
#	draw_rect(rect,Color(1,1,1,0.5))
#	var matrix = hitbox.get_shape_transform(0)
#	var p1 = matrix.xform(rect.pos)
#	var p2 = matrix.xform(rect.end)
#	var p3 = matrix.xform(Vector2(rect.pos.x,rect.end.y))
#	var p4 = matrix.xform(Vector2(rect.end.x,rect.pos.y))
#	draw_circle(p1,2,Color(1,1,1,1))
#	draw_circle(p2,2,Color(1,1,1,1))
#	draw_circle(p3,2,Color(1,1,1,1))
#	draw_circle(p4,2,Color(1,1,1,1))