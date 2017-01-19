extends "res://Scripts/skill.gd"

#var texture

var multiplier

#CLASS METHODS

static func get_skill_name(): return "Defend"
static func get_mp_cost(): return 0
static func get_cooldown(): return 0.5

#OTHER METHODS

func _ready():
#	texture = get_parent().get_texture()
	multiplier = 2

func _process(delta):
	if (active):
		user.set_using_skill(1)

func _button(pressed):
	if (pressed):
		active = true
		user.set_current_stat(cons.DEF,user.get_current_stat(cons.DEF)*multiplier)
	else:
		user.set_current_stat(cons.DEF,user.get_current_stat(cons.DEF)/multiplier)
		active = false
		user.set_using_skill(0)

func finished():
	active = false