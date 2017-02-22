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

static func get_skill_name(): return "Fireball"
static func get_mp_cost(): return 2
static func get_cooldown(): return 1

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
	projectile = projectile_scn.instance()
	projectile.set_script(projectile_script)
	get_node("/root/Main").add_child(projectile)
	projectile.set_texture(texture)
	projectile.set_global_pos(user.get_global_pos())
	projectile.set_direction_vector(user.get_forward())

#func effect():
#	active = true
#	return true

#func finished():
#	active = false