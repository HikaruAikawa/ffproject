extends "res://Scripts/animated_entity.gd"

#DEFINITION OF CONSTANTS

const HP = 0
const MP = 1
const ATK = 2
const DEF = 3
const SPD = 4
const MAX_STATS = 5

#DEFINITION OF VARIABLES

var script
#Current health and magic points
var current_hp
var current_mp
#Maximum health and magic points
var base_stats
var current_stats
#Timer for the animation of taking damage
var damage_time
var damage_timer
var knockback
var knockback_timer
#Timer for the invincibility time after taking damage
var inv_time
var inv_timer
#Timer for the blinking animation when the character is invincible
var blink_time
var blink_timer
var blink_state
var blinking_timer
#var blinking_time
#Timer for the use of a skill
var skill_time
var skill_timer

func is_player(): return false
func is_enemy(): return false

func _ready():
	
	damage_timer = 0
	knockback_timer = 0
	inv_timer = 0
	blink_timer = 0
	blinking_timer = 0
	skill_timer = 0
	blink_state = false
	
	#Gets the class to access static methods
	script = get_script()
	
	#Gets the data from the class
	base_stats = script.get_base_stats()
	current_stats = []
	current_stats.resize(MAX_STATS)
	for i in range(MAX_STATS):
		current_stats[i] = base_stats[i]
	
	#Sets HP and MP
	current_hp = current_stats[HP]
	current_mp = current_stats[MP]
	movement_speed = current_stats[SPD]

func _process(delta):
	movement_speed = current_stats[SPD]
	if (get_state() == ST_SKILL):
		skill_timer -= delta
		if (skill_timer <= 0):
			set_state(ST_IDLE)
	#If the knockback timer is not 0, gets knocked back
	if(knockback_timer>0):
		knockback_timer -= delta
		move(knockback*(delta/damage_time))
		if (test_move(knockback*(delta/damage_time))): knockback_timer = 0
	elif (get_state() == ST_HURT):
		#If the damage timer is not 0, counts down
		if(damage_timer>0):
			damage_timer -= delta
			#Changes color to red (experimental)
			sprite.set_modulate(Color(1,0,0,1))
			#If it collides, stop moving backwards
		#If it is, returns to natural state
		else:
			set_state(ST_IDLE)
			sprite.set_modulate(Color(1,1,1,1))
			blinking_timer = inv_timer
	if(inv_timer>0):
		inv_timer -= delta
	if (blinking_timer>0):
		#This timer switches the blinking state (between transparent and solid) when it reaches 0, then resets
		#(Only if it's not getting knocked back)
		#if (damage_timer<=0):
		blink_timer -= delta
		blinking_timer -= delta
		if (blink_timer<=0):
			switch_blinking()
			blink_timer = blink_time
	else: if (blink_state): switch_blinking()

#Sets the entity to the state using a skill
func set_using_skill(time):
	set_state(ST_SKILL)
	skill_timer = time

func get_current_stat(i): return current_stats[i]
func set_current_stat(i,val): current_stats[i] = val

#Increases (or decreases) health points by the given amount
func increase_hp(amount):
	current_hp+=amount
	if (current_hp<=0): die()
	elif (current_hp>current_stats[HP]): current_hp=current_stats[HP]

#Increases (or decreases) magic points by the given amount
func increase_mp(amount):
	current_mp+=amount
	if (current_mp<0): current_mp=0
	elif (current_mp>current_stats[MP]): current_mp=current_stats[MP]

#Takes a certain amount of damage and is knocked back
func take_damage(amount,kb):
	if(!is_invincible()):
		if (amount-current_stats[DEF] > 0):
			damage_timer = damage_time
			inv_timer = inv_time
			blink_timer = blink_time
			increase_hp(-(amount-current_stats[DEF]))
			set_state(ST_HURT)
		knockback_timer = damage_time
		knockback = kb

func switch_blinking():
	if (blink_state == false):
		sprite.set_modulate(Color(1,1,1,0.5))
		blink_state = true
	else:
		sprite.set_modulate(Color(1,1,1,1))
		blink_state = false

func set_invincible(time):
	inv_timer = time

func is_invincible():
	return inv_timer>0

func die():
	self.queue_free()
