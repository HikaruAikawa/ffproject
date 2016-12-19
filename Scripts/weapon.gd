#DEFINITION OF CONSTANTS

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF VARIABLES

#The class that can use this weapon
var using_class
#The player currently using this weapon
var user
#The index of this weapon
var index
#The name of this weapon
var name
#An array with the skills assigned to this weapon
var skills
#An array containing whether the skills are useable or not
var skills_available

#DEFINITION OF METHODS

func _init(id,usr):
	index = id
	user = usr
	skills = []
	skill_class = preload("res://Scripts/skill.gd")

#Uses the skill in the position i, if it's available
func use_skill(i):
	if (skills_available[i]): get_skill(i).use()

#Sets the name of the weapon
func set_name(nm):
	name = nm

#Sets the array of skills assigned to this weapon
func add_skill(id):
	sk = skill_class.new()
	sk.set_script(load("res://Scripts/Skills/skill_"+id+".gd"))
	user.add_child(sk)
	sk.set_owner(user)
	skills.append(sk)

#Returns the name of this weapon
func get_name():
	return name

#Returns the skill in the position i
func get_skill(i):
	return skills[i]

#Returns the index of this weapon
func get_index():
	return index
