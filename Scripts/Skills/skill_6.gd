extends "res://Scripts/Skills/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

var user_dir
var user_dir_left
var user_dir_right

#CLASS METHODS

static func get_skill_name(): return "Wide attack"
static func get_mp_cost(): return 3
static func get_cooldown(): return 2

#OTHER METHODS

func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/Skills/SkillElements/swing.gd")
	
	swing_start_time = 0.05
	swing_time = 0.2
	swing_end_time = 0.1

func effect():
	
	user_dir = user.get_direction()
	user_dir_right = user_dir-1
	if (user_dir_right < 0): user_dir_right = 3
	user_dir_left = user_dir+1
	if (user_dir_left > 3): user_dir_left = 0
	
	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.set_user(user)
	swing.set_attack(10,64)
	swing.set_sprite(texture,Vector2(0,0),16)
	if (user_dir == cons.DR_DOWN || user_dir == cons.DR_UP):
		swing.set_hitbox(16*user.get_forward(),Vector2(96,64))
	else:
		swing.set_hitbox(16*user.get_forward(),Vector2(64,96))
	swing.set_times(swing_time,swing_start_time,swing_end_time)
	var ang = get_user_rotation()
	swing.set_angles(ang+PI/2,ang-PI/2)
	add_child(swing)
	swing.set_owner(self)
	active = true
	return true

func _process(delta):
	if (active):
		pass
#		var timer = swing.get_timer()
#		if (timer > 2*swing_time/3): user.set_direction(user_dir_left)
#		elif (timer <= swing_time/3): user.set_direction(user_dir_right)
#		else: user.set_direction(user_dir)

func finished():
	active = false
	user.set_direction(user_dir)
	swing.queue_free()