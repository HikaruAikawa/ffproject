#An enemy's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

#DEFINITION OF VARIABLES

#This enemy's body hitbox (and hurtbox)
var hitbox


func is_enemy(): return true
func is_player(): return false

func _ready():
	
	#Gets the data from the script
	sprite.set_texture(script.get_texture())
	
	damage_time = 0.2
	inv_time = 1
	blink_time = 0.1
	
	hitbox = get_node("Hitbox")

func init_animations():
	animations = {
		cons.ST_IDLE : {
			cons.DR_UP:		[[10],[0]],
			cons.DR_LEFT:	[[4],[0]],
			cons.DR_DOWN:	[[1],[0]],
			cons.DR_RIGHT:	[[7],[0]]
		} ,
		cons.ST_MOVING : {
			cons.DR_UP:		[[9,10,11,10],[10,10,10,10]],
			cons.DR_LEFT:	[[3,4,5,4],[10,10,10,10]],
			cons.DR_DOWN:	[[0,1,2,1],[10,10,10,10]],
			cons.DR_RIGHT:	[[6,7,8,7],[10,10,10,10]]
		} ,
		cons.ST_HURT : {
			cons.DR_UP:		[[10],[0]],
			cons.DR_LEFT:	[[4],[0]],
			cons.DR_DOWN:	[[1],[0]],
			cons.DR_RIGHT:	[[7],[0]]
		}
	}
	set_animation()

func _process(delta):
	
	#If it collides with a player, it deals damage
	for hit in hitbox.get_overlapping_areas():
		var target = hit.get_parent()
		if (hit.get_layer_mask_bit(cons.LYH_PLAYERS) && get_state() != cons.ST_HURT && !is_invincible()):
			target.take_damage(10,15*((target.get_global_pos()-get_global_pos()).normalized()))
