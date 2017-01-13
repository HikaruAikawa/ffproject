extends "res://Scripts/skill.gd"

var texture

var projectile
var projectile_scn
var projectile_script

#CLASS METHODS

static func get_skill_name(): return "Projectile"
static func get_mp_cost(): return 0
static func get_cooldown(): return 1

#OTHER METHODS

func _ready():
	texture = load("res://Textures/Entities/projectile_0.tex")
	projectile_scn = load("res://Scenes/Entities/Projectile.tscn")
	projectile_script = load("res://Scripts/Skills/SkillElements/projectile.gd")

func effect():
	projectile = projectile_scn.instance()
	projectile.set_script(projectile_script)
	get_node("/root/Main").add_child(projectile)
	projectile.set_texture(texture)
	projectile.set_global_pos(user.get_global_pos())
	projectile.set_direction(user.get_direction())
	return true

#func effect():
#	active = true
#	return true

#func finished():
#	active = false