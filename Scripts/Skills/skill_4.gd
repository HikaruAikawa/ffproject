extends "res://Scripts/skill.gd"

var texture
var multiplier
var sprite

#CLASS METHODS

static func get_skill_name(): return "Defend"
static func get_mp_cost(): return 0
static func get_cooldown(): return 0.5

#OTHER METHODS

func _ready():
	texture = get_parent().get_texture()
	multiplier = 2

func _process(delta):
	if (active):
		user.set_using_skill(1)

func _button(pressed):
	if (pressed):
		if (user.get_state() == cons.ST_IDLE || user.get_state() == cons.ST_MOVING): activate()
	else:
		if (user.get_state() == cons.ST_SKILL): deactivate()

func activate():
	active = true
	user.set_current_stat(cons.DEF,user.get_current_stat(cons.DEF)*multiplier)
	emit_signal("entered_cooldown",true)
	sprite = Sprite.new()
	sprite.set_texture(texture)
	user.add_child(sprite)
	sprite.set_pos(5*user.get_forward()+Vector2(0,5))
	if (user.get_direction() == cons.DR_UP): sprite.set_z(-1)

func deactivate():
	user.set_current_stat(cons.DEF,user.get_current_stat(cons.DEF)/multiplier)
	active = false
	user.set_using_skill(0)
	emit_signal("exited_cooldown")
	if (sprite != null):
		sprite.queue_free()
		sprite = null

func finished():
	active = false