#Player's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

export var player_number = 0
var skill
var sprite

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF METHODS

func _ready():
	sprite = find_node("Sprite")
	damage_time = 0.2
	inv_time = 3
	#Creates the skill that will be used (testing purposes)
	skill = new_skill(0)

func set_player_number(n):
	player_number = n

#Initializes all animations into arrays
func init_animations():
	animations = {
		ST_IDLE : {
			DR_UP:		[[10],[0]],
			DR_LEFT:	[[4],[0]],
			DR_DOWN:	[[1],[0]],
			DR_RIGHT:	[[7],[0]]
		} ,
		ST_MOVING : {
			DR_UP:		[[9,10,11,10],[10,10,10,10]],
			DR_LEFT:	[[3,4,5,4],[10,10,10,10]],
			DR_DOWN:	[[0,1,2,1],[10,10,10,10]],
			DR_RIGHT:	[[6,7,8,7],[10,10,10,10]]
		} ,
		ST_HURT : {
			DR_UP:		[[10],[0]],
			DR_LEFT:	[[4],[0]],
			DR_DOWN:	[[1],[0]],
			DR_RIGHT:	[[7],[0]]
		}
	}
	set_animation()

static func get_class_script(cl):
	if (cl == CL_NIGHT): return preload("res://Scripts/player_classes/Night.gd")
	elif (cl == CL_MAIGE): return preload("res://Scripts/player_classes/Maige.gd")
