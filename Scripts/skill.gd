extends Node2D

#DEFINITION OF VARIABLES 

#How much MP will be depleted when the skill is used
var mp_cost
#The time in seconds it takes for the ability to become useable again
var cooldown
var cooldown_timer
#A reference to the entity using this skill
var user

#When created, takes the entity that will use it
#func _init(usr):
#	user = usr

#Enables processing
func _init():
	set_process(true)
	cooldown_timer = 0

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