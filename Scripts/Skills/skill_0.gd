extends "res://Scripts/skill.gd"

var swing
var texture
var swing_script

var swing_time
var swing_start_time
var swing_end_time

var active

#CLASS METHODS

static func get_mp_cost(): return 0
static func get_cooldown(): return 0.5

#OTHER METHODS
func _ready():
	texture = get_parent().get_texture()
	swing_script = load("res://Scripts/swing.gd")
	
	swing_start_time = 0
	swing_time = 0.1
	swing_end_time = 0.1
	
	active = false

func effect():
	user.set_using_skill(swing_time + swing_start_time + swing_end_time)
	swing = Node2D.new()
	swing.set_script(swing_script)
	swing.initialize(user,texture,swing_time,swing_start_time,swing_end_time,-PI/4,PI/4,32,10,15,10)
	add_child(swing)
	swing.set_owner(self)
	active = true
	return true

func finished():
	active = false