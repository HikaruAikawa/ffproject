extends Node2D

#DEFINITION OF CONSTANTS

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF VARIABLES

var global
var script
#The class that can use this weapon
var using_class
#The player currently using this weapon
var user
#The index of this weapon
var id
#The name of this weapon
var name
#The sprite of this weapon
var texture
#An array with the skills assigned to this weapon
var skills

#DEFINITION OF METHODS

func _ready():
	global = get_node("/root/global")
	script = get_script()
	skills = []
	user = get_parent()
	id = script.get_id()
	for sk_id in script.get_skill_ids():
		add_skill(sk_id)

#Uses the skill in the position i, if it's available
func use_skill(i):
	skills[i].use()

#Sets the name of the weapon
func set_name(nm):
	name = nm

#Sets the array of skills assigned to this weapon
func add_skill(sk_id):
	var skill_class = preload("res://Scripts/skill.gd")
	var sk = skill_class.new()
	sk.set_script(global.get_skill_script(sk_id))
	add_child(sk)
	sk.set_owner(self)
	sk.set_name("Skill "+str(sk_id))
	sk.set_user(user)
	skills.append(sk)

#Returns the name of this weapon
func get_name():
	return name

#Returns the skill in the position i
func get_skill(i):
	return skills[i]

#Returns the index of this weapon
func get_id():
	return id

func get_texture():
	return texture
