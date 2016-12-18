extends "res://Scripts/animated_entity.gd"

#DEFINITION OF CONSTANTS

const HP = 0
const MP = 1
const ATK = 2
const DEF = 3
const SPD = 4

#DEFINITION OF VARIABLES

#The base stats of this entity
var base_stats
#The current stats of this entity
var current_stats
#Current health and magic points
var current_hp
var current_mp
#Timer for the animation of taking damage
var damage_time
var damage_timer
var knockback
#Timer for the invincibility time after taking damage
var inv_time
var inv_timer
#Timer for the blinking animation when the character is invincible
var blink_time
var blink_timer
var blink_state

func _ready():
	damage_timer = 0
	inv_timer = 0
	blink_timer = 0
	blink_state = false

func _process(delta):
	if(get_state() == ST_HURT):
		#If the damage timer is not 0, counts down and gets knocked back
		if(damage_timer>0):
			damage_timer -= delta
			move(knockback*(delta/damage_time))
			#Changes color to red (experimental)
			sprite.set_modulate(Color(1,0,0,1))
			#If it collides, stop moving backwards
			if (test_move(knockback*(delta/damage_time))): damage_timer = 0
		#If it is, returns to natural state
		else:
			set_state(ST_IDLE)
			sprite.set_modulate(Color(1,1,1,1))
	if(inv_timer>0):
		inv_timer -= delta
		#This timer switches the blinking state (between transparent and solid) when it reaches 0, then resets
		#(Only if it's not getting knocked back)
		if (damage_timer<=0):
			blink_timer -= delta
			if (blink_timer<=0):
				switch_blinking()
				blink_timer = blink_time
	else: if (blink_state): switch_blinking()

#Returns the given stat
func get_stat(stat):
	return current_stats[stat]

#Returns the given base stat
func get_base_stat(stat):
	return base_stats[stat]

#Increases (or decreases) health points by the given amount
func increase_hp(amount):
	current_hp+=amount
	if (current_hp<0): current_hp=0
	elif (current_hp>current_stats[HP]): current_hp=current_stats[HP]

#Increases (or decreases) magic points by the given amount
func increase_mp(amount):
	current_mp+=amount
	if (current_mp<0): current_mp=0
	elif (current_mp>current_stats[MP]): current_mp=current_stats[MP]

#Takes a certain amount of damage and is knocked back
func take_damage(amount,kb):
	if(inv_timer<=0):
		damage_timer = damage_time
		inv_timer = inv_time
		blink_timer = blink_time
		increase_hp(-amount)
		set_state(ST_HURT)
		knockback = kb

func switch_blinking():
	if (blink_state == false):
		sprite.set_modulate(Color(1,1,1,0.5))
		blink_state = true
	else:
		sprite.set_modulate(Color(1,1,1,1))
		blink_state = false