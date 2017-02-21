extends "res://Scripts/Enemies/enemy.gd"

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

func _ready():
	
	turn_time = 1
	turn_timer = turn_time
	
	map = get_node("/root/Main/Map")
	path = []

func _process(delta):
	#Gets the path to the player, if it exists
	target = null
	set_target()
	
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

func set_target():
	var player_list = get_node("/root/Main").get_player_list()
	var dist = 0
	for player in player_list.values():
		if (player != null):
			var prov = player.get_global_pos()-get_global_pos()
			if (dist == 0 || prov.length() < dist):
				dist = prov.length()
				target = player
