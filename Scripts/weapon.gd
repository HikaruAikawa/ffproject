extends Node2D

#DEFINITION OF VARIABLES

var script
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
#The amount of skills this weapon has unlocked
var skills_unlocked

#DEFINITION OF METHODS

func _ready():
	script = get_script()
	skills = []
	user = get_parent()
	name = script.get_name()
	for sk_id in script.get_skill_ids():
		add_skill(sk_id)
	set_skills_unlocked(3)

#Uses the skill in the position i, if it's available
func use_skill(i):
	skills[i].use()

#Sets the name of the weapon
func set_name(nm):
	name = nm

#Sets the array of skills assigned to this weapon
func add_skill(sk_id):
	var skill_class = preload("res://Scripts/Skills/skill.gd")
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

func get_skills_unlocked(): return skills_unlocked

func set_skills_unlocked(n): skills_unlocked = n


#func get_skills():
#	return skills

func get_texture():
	return texture
