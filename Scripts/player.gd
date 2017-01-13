#Player's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

#DEFINITION OF CONSTANTS

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF VARIABLES 

var weapons
var global

var player_number

#DEFINITION OF METHODS

func is_player(): return true
func is_enemy(): return false

func _ready():
	
	#Saves the global node
	global = get_node("/root/global")
	
	#Gets the data from the class
	sprite.set_texture(script.get_texture())
	
	damage_time = 0.2
	inv_time = 3
	blink_time = 0.1
	
	weapons = [null, null]

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

#Replaces the current weapon with the given one
func equip_weapon(slot,id):
	if (weapons[slot] != null):
		weapons[slot].free()
	weapons[slot] = Node2D.new()
	if (slot == 0): weapons[slot].set_name("RWeapon")
	elif (slot == 1): weapons[slot].set_name("LWeapon")
	weapons[slot].set_script(global.get_weapon_script(get_id(),slot,id))
	add_child(weapons[slot])
	weapons[slot].set_owner(self)

#Returns the current weapon
func get_weapon(slot):
	return weapons[slot]

func die():
	get_node("/root/Main").remove_player(player_number)
	.die()