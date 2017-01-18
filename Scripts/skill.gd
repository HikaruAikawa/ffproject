extends Node2D

#DEFINITION OF VARIABLES 

var script
#How much MP will be depleted when the skill is used
var mp_cost
#The time in seconds it takes for the ability to become useable again
var cooldown
var cooldown_timer
#A reference to the entity using this skill
var user
#Stores whether or not this skill is already unlocked or not
var unlocked
#Stores whether or not the skill is being used
var active

#Enables processing
func _ready():
	script = get_script()
	mp_cost = script.get_mp_cost()
	cooldown = script.get_cooldown()
	cooldown_timer = 0
	unlocked = false
	active = false
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

#By default, when the button is pressed, the skill is used
func _button(pressed):
	if (pressed):
		if (user.get_state() == cons.ST_IDLE || user.get_state() == cons.ST_MOVING):
			if (!user.is_in_knockback()):
				use()

func set_unlocked(b): unlocked = b
func is_unlocked(): return unlocked

#Utility methods for other skills

func turn_user(n):
	var dir = user.get_direction()
	dir += n
	if (dir > 3): dir = 0
	elif (dir < 0): dir = 3
	user.set_direction(dir)