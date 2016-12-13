#An enemy's main node, a kinematic body
extends "res://Scripts/fighting_entity.gd"

#The map on which to find a path
var map
#An array of points towards the target
var path
#The target to follow
var player
#A timer to delay turning
var turn_timer
#Time it takes to turn, in seconds
var turn_time
#A small amount, to check if it should turn immediately
var eps

func _init():
	eps = 0.5
	turn_time = 1
	turn_timer = turn_time

func _ready():
	movement_speed = 1
	map = get_node("../Map")
	player = get_node("../Night")
	path = []

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
		}
	}
	set_animation()

func _process(delta):
	#Gets the path to the player
	path = map.get_simple_path(get_global_pos(),player.get_global_pos(),false)
	#Increases the timer for turning
	if(turn_timer<turn_time): turn_timer += delta
	#If it hits a wall, ignores the timer and turns
	if(test_move(movement_speed*forward)): turn_timer = turn_time
	#Only moves if there are enough points
	if (path.size()>2):
		#If it's directly in line with the target, ignores the timer and turns
		if(abs((path[2]-get_global_pos()).x) < eps || abs((path[2]-get_global_pos()).y) < eps): turn_timer = turn_time
		if (get_state()==ST_IDLE || get_state()==ST_MOVING):
			set_state(ST_MOVING)
			#What these checks do, in order:
			#1. Check which cardinal direction the movement is closest to, and set that direction
			#2. If there is a wall in that direction, check which other direction it's the closest to
			if(turn_timer>=turn_time):
				var angle = (path[2]-get_global_pos()).angle()
				if (-PI*3/4<=angle && angle<-PI/4):
					set_direction(DR_LEFT)
					if(test_move(movement_speed*forward)):
						if(angle<-PI/2): set_direction(DR_UP)
						else: set_direction(DR_DOWN)
				elif (-PI/4<=angle && angle<PI/4):
					set_direction(DR_DOWN)
					if(test_move(movement_speed*forward)):
						if(angle<0): set_direction(DR_LEFT)
						else: set_direction(DR_RIGHT)
				elif (PI/4<=angle && angle<3*PI/4):
					set_direction(DR_RIGHT)
					if(test_move(movement_speed*forward)):
						if(angle<PI/2): set_direction(DR_DOWN)
						else: set_direction(DR_UP)
				else:
					set_direction(DR_UP)
					if(test_move(movement_speed*forward)):
						if(angle<0): set_direction(DR_LEFT)
						else: set_direction(DR_RIGHT)
				turn_timer = 0
	else: set_state(ST_IDLE)
	
	#If it collides with a player, it deals damage
	if(is_colliding()):
		print("Collision")
		var collider = get_collider()
		if(collider extends PhysicsBody2D):
			print("With physics body")
			if(collider.get_collision_mask_bit(1)):
				print("With player")
				collider.take_damage(10,10*(get_collider().get_global_pos()-get_global_pos()))