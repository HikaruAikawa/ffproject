extends "res://Scripts/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

var active
var progress

#CLASS METHODS

static func get_skill_name(): return "Circular attack"
static func get_mp_cost(): return 10
static func get_cooldown(): return 3

#OTHER METHODS
func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/Skills/SkillElements/swing.gd")
	
	swing_start_time = 0.1
	swing_time = 0.4
	swing_end_time = 0.1
	
	active = false
	progress = 0

func effect():
	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.initialize(user,texture,swing_time,swing_start_time,swing_end_time,0,2*PI,32,10,96,16)
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