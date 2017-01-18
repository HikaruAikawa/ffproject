extends "res://Scripts/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

var distance
var initial_pos
var target_pos

#CLASS METHODS

static func get_skill_name(): return "Dashing attack"
static func get_mp_cost(): return 4
static func get_cooldown(): return 1.5

#OTHER METHODS

func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/Skills/SkillElements/swing.gd")
	
	swing_start_time = 0.1
	swing_time = 0.1
	swing_end_time = 0.2
	
	distance = 128

func effect():
	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	user.set_invincible(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.set_user(user)
	swing.set_attack(10,16)
	swing.set_sprite(texture,4*user.get_forward(),4)
	swing.set_hitbox(24*user.get_forward(),Vector2(32,32))
	swing.set_times(swing_time,swing_start_time,swing_end_time)
	var ang = get_user_rotation()
	swing.set_angles(ang+PI/4,ang-PI/4)
	add_child(swing)
	swing.set_owner(self)
	active = true
	initial_pos = user.get_global_pos()
	target_pos = initial_pos + distance*user.get_forward()
	return true

func _process(delta):
	if (active):
		var timer = swing.get_timer()
		if (timer <= swing_time && timer > 0):
			var pos = user.get_global_pos()
			var next_pos = initial_pos.linear_interpolate(target_pos,1-(timer/swing_time))
			var moved = user.move_to(next_pos)
			if (moved != Vector2(0,0)): timer = 0
		elif (timer < 0):
			user.move_to(target_pos)

func finished():
	active = false
	user.set_using_skill(0)
	swing.queue_free()