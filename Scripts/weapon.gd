
#The index of this weapon
var index
#The name of this weapon
var name
#An array with the skills assigned to this weapon
var skills
#How many of the skills are available to use
var skills_available

#Constructor takes the name and the skills
func _init(nm,sk,ind):
	set_name(nm)
	set_skill(sk)
	index = ind

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#Uses the skill in the position i, if it's available
func use_skill(i):
	if (skills_available[i]): get_skill(i).use()

#Sets the name of the weapon
func set_name(nm):
	name = nm

#Sets the array of skills assigned to this weapon
func set_skills(sk):
	skills = sk

#Returns the name of this weapon
func get_name():
	return name

#Returns the skill in the position i
func get_skill(i):
	return skills[i]

#Returns the index of this weapon
func get_index(ind):
	return index
