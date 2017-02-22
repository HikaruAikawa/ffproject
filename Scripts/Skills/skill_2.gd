extends "res://Scripts/Skills/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

var progress

#CLASS METHODS

static func get_skill_name(): return "Circular attack"
static func get_mp_cost(): return 6
static func get_cooldown(): return 3

#OTHER METHODS

func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/Skills/SkillElements/swing.gd")
	
	swing_start_time = 0.1
	swing_time = 0.4
	swing_end_time = 0.1
	progress = 0

func effect():

	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.set_user(user)
	swing.set_attack(10,96)
	swing.set_sprite(texture,Vector2(0,0),16)
	swing.set_hitbox(Vector2(0,0),Vector2(96,96))
	swing.set_times(swing_time,swing_start_time,swing_end_time)
	var ang = get_user_rotation()
	swing.set_angles(ang,ang-2*PI)
	add_child(swing)
	swing.set_owner(self)
	active = true
	return true

func _process(delta):
	if (active):
		var timer = swing.get_timer()
		if (timer <= swing_start_time + swing_time):
			var new_progress = lerp(0,4,1-(timer/swing_time))
			for i in range(0,4):
				if (progress+1 <= i+1 && new_progress+1 > i+1):
					turn_user(-1)
			progress = new_progress

func finished():
	active = false
	swing.queue_free()