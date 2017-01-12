extends Node2D

#DEFINITION OF CONSTANTS

const ST_IDLE = 0
const ST_MOVING = 1
const ST_HURT = 2
const ST_SKILL = 3
const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3

#DEFINITION OF VARIABLES 

var script
#How much MP will be depleted when the skill is used
var mp_cost
#The time in seconds it takes for the ability to become useable again
var cooldown
var cooldown_timer
#A reference to the entity using this skill
var user

#Enables processing
func _ready():
	script = get_script()
	mp_cost = script.get_mp_cost()
	cooldown = script.get_cooldown()
	cooldown_timer = 0
	set_process(true)

#Every frame, the cooldown timer will decrease if it's not 0
func _process(delta):
	if (cooldown_timer>0): cooldown_timer -= delta
	elif (cooldown_timer<0): cooldown_timer = 0

func set_user(usr):
	user = usr

#When used, takes effect
func use():
	if (cooldown_timer==0 && user.current_mp >= mp_cost):
		if(effect()):
			user.increase_mp(-mp_cost)
			cooldown_timer = cooldown

#Utility methods for other skills

func turn_user(n):
	var dir = user.get_direction()
	dir += n
	if (dir > 3): dir = 0
	elif (dir < 0): dir = 3
	user.set_direction(dir)