#Player's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

#DEFINITION OF CONSTANTS

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF VARIABLES 
var cl_script

#The current stats of this entity
var current_stats
var player_number
var skill

#DEFINITION OF METHODS

func _ready():
	
	#Gets the class to access static methods
	cl_script = get_script()
	
	#Gets the data from the class
	sprite.set_texture(cl_script.get_texture())
	current_stats = []
	current_stats.resize(MAX_STATS)
	for i in range(MAX_STATS):
		current_stats[i] = cl_script.get_base_stat(i)
	
	#Sets HP and MP
	max_hp = current_stats[HP]
	max_mp = current_stats[MP]
	current_hp = max_hp
	current_mp = max_mp
	
	damage_time = 0.2
	inv_time = 3
	blink_time = 0.1
	#Creates the skill that will be used (testing purposes)
	skill = new_skill(1)

func _process(delta):
	movement_speed = current_stats[SPD]

func set_player_number(n):
	player_number = n

func get_player_number():
	return player_number

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
		} ,
		ST_SKILL : {
			DR_UP:		[[9],[0]],
			DR_LEFT:	[[3],[0]],
			DR_DOWN:	[[0],[0]],
			DR_RIGHT:	[[6],[0]]
		}
	}
	set_animation()

#Returns the given stat
func get_stat(stat):
	return current_stats[stat]
