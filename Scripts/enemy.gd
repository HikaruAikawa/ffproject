#An enemy's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

#DEFINITION OF VARIABLES

#This enemy's body hitbox (and hurtbox)
var hitbox
#The map on which to find a path
var map
#An array of points towards the target
var path
#The target to follow
var target
#A timer to delay turning
var turn_timer
#Time it takes to turn, in seconds
var turn_time


func is_enemy(): return true
func is_player(): return false

func _ready():
	
	#Gets the data from the script
	sprite.set_texture(script.get_texture())
	
	turn_time = 1
	turn_timer = turn_time
	damage_time = 0.2
	inv_time = 1
	blink_time = 0.1
	
	map = get_node("/root/Main/Map")
	path = []
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
	#Gets the path to the player, if it exists
	target = null
	var player_list = get_node("/root/Main").get_player_list()
	var dist = 0
	for player in player_list.values():
		if (player != null):
			var prov = player.get_global_pos()-get_global_pos()
			if (dist == 0 || prov.length() < dist):
				dist = prov.length()
				target = player
	
	if (target != null):
		path = map.get_simple_path(get_global_pos(),target.get_global_pos(),false)
		#Increases the timer for turning
		if(turn_timer<turn_time): turn_timer += delta
		#If it hits a wall, ignores the timer and turns
		if(test_move(movement_speed*forward)): turn_timer = turn_time
		#Only moves if there are enough points
		if (path.size()>2):
			#If it's directly in line with the target, ignores the timer and turns
			if(abs((path[2]-get_global_pos()).x) < cons.EPS || abs((path[2]-get_global_pos()).y) < cons.EPS): turn_timer = turn_time
			if (get_state()==cons.ST_IDLE || get_state()==cons.ST_MOVING):
				set_state(cons.ST_MOVING)
				#What these checks do, in order:
				#1. Check which cardinal direction the movement is closest to, and set that direction
				#2. If there is a wall in that direction, turn to the other direction it's the closest to
				if(turn_timer>=turn_time):
					var angle = (path[2]-get_global_pos()).angle()
					if (-PI<=angle && angle<-PI/2):
						if (angle<-3*PI/4):
							set_direction(cons.DR_UP)
							if (test_move(forward)): set_direction(cons.DR_LEFT)
						else:
							set_direction(cons.DR_LEFT)
							if (test_move(forward)): set_direction(cons.DR_UP)
					elif (-PI/2<=angle && angle<0):
						if (angle<-PI/4):
							set_direction(cons.DR_LEFT)
							if (test_move(forward)): set_direction(cons.DR_DOWN)
						else:
							set_direction(cons.DR_DOWN)
							if (test_move(forward)): set_direction(cons.DR_LEFT)
					elif (0<=angle && angle<PI/2):
						if (angle<PI/4):
							set_direction(cons.DR_DOWN)
							if (test_move(forward)): set_direction(cons.DR_RIGHT)
						else:
							set_direction(cons.DR_RIGHT)
							if (test_move(forward)): set_direction(cons.DR_DOWN)
					else:
						if (angle<3*PI/4):
							set_direction(cons.DR_RIGHT)
							if (test_move(forward)): set_direction(cons.DR_UP)
						else:
							set_direction(cons.DR_UP)
							if (test_move(forward)): set_direction(cons.DR_RIGHT)
					turn_timer = 0
		else: if (get_state() == cons.ST_MOVING): set_state(cons.ST_IDLE)
	else: if (get_state() == cons.ST_MOVING): set_state(cons.ST_IDLE)
	
	#If it collides with a player, it deals damage
	for hit in hitbox.get_overlapping_areas():
		var target = hit.get_parent()
		if (hit.get_layer_mask_bit(cons.LYH_PLAYERS) && get_state() != cons.ST_HURT && !is_invincible()):
			target.take_damage(10,15*((target.get_global_pos()-get_global_pos()).normalized()))
