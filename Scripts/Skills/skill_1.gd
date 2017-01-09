extends "res://Scripts/skill.gd"

var swing_scn = preload("res://Scenes/Swing.tscn")
var swing
var texture

#CLASS METHODS

static func get_mp_cost(): return 2
static func get_cooldown(): return 0.5

#OTHER METHODS
func _ready():
	texture = get_parent().get_texture()

func effect():
	user.set_using_skill(0.2)
	swing = swing_scn.instance()
	swing.initialize(user,texture,0.2,-PI/2,24)
	add_child(swing)
	swing.set_owner(self)
	return true
