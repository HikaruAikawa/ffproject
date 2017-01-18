extends "res://Scripts/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

#CLASS METHODS

static func get_skill_name(): return "Attack"
static func get_mp_cost(): return 0
static func get_cooldown(): return 0.5

#OTHER METHODS

func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/Skills/SkillElements/swing.gd")
	
	swing_start_time = 0.05
	swing_time = 0.1
	swing_end_time = 0.05

func effect():

	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.set_user(user)
	swing.set_attack(10,16)
	swing.set_sprite(texture,4*user.get_forward(),4)
	swing.set_hitbox(24*user.get_forward(),Vector2(32,32))
	swing.set_times(swing_time,swing_start_time,swing_end_time)
	var ang = get_user_rotation()
	swing.set_angles(ang+PI/6,ang-PI/6)
	add_child(swing)
	swing.set_owner(self)
	active = true
	return true

func finished():
	active = false
	swing.queue_free()