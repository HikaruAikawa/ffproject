extends "res://Scripts/Skills/skill.gd"

var texture

var projectile
var projectile_scn
var projectile_script

var casting_time
var delay_time
var casting_timer
var projectile_thrown

#CLASS METHODS

static func get_skill_name(): return "Triple Fireball"
static func get_mp_cost(): return 8
static func get_cooldown(): return 1.5

#OTHER METHODS

func _ready():
	texture = load("res://Textures/Entities/projectile_0.tex")
	projectile_scn = load("res://Scenes/Entities/Projectile.tscn")
	projectile_script = load("res://Scripts/Skills/SkillElements/projectile.gd")
	
	casting_time = 0.25
	delay_time = 0.25

func effect():
	casting_timer = casting_time + delay_time
	user.set_using_skill(casting_timer)
	projectile_thrown = false
	
	active = true
	return true

func _process(delta):
	if (active):
		casting_timer -= delta
		if (casting_timer < delay_time):
			if (!projectile_thrown):
				throw_projectile()
				projectile_thrown = true
		if (casting_timer < 0):
			active = false
			user.set_state(cons.ST_IDLE)

func throw_projectile():
	var i
	for i in range(0,3):
		projectile = projectile_scn.instance()
		projectile.set_script(projectile_script)
		get_node("/root/Main").add_child(projectile)
		projectile.set_texture(texture)
		projectile.set_global_pos(user.get_global_pos())
		if (i == 0): projectile.set_direction_vector(user.get_forward())
		elif (i == 1): projectile.set_direction_vector(user.get_forward().rotated(PI/6))
		elif (i == 2): projectile.set_direction_vector(user.get_forward().rotated(-PI/6))

#func effect():
#	active = true
#	return true

#func finished():
#	active = false