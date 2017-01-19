extends KinematicBody2D

#DEFINITION OF VARIABLES

#State and direction
var state setget set_state,get_state
var direction setget set_direction,get_direction
#Movement speed
var movement_speed
#Vectors to store forward and right directions
var forward
var right
#The sprite of this entity (should be a child node)
var sprite
#Animation timers, array containing animation frames and delay between frames
var animation_timer
var current_animation
var current_animation_delays
var animation_delay_timer
#Will contain all animations
var animations

#DEFINITION OF METHODS

#Initialization method
func _ready():
	#Gets child node for the sprite
	sprite = get_node("Sprite")
	#Sets animation properties
	animation_delay_timer = 0
	set_state_direction(cons.ST_IDLE,cons.DR_DOWN)
	init_animations()
	#Enables the use of process and fixed process
	set_process(true)
	set_fixed_process(true)

#Process method (called every frame)
func _process(delta):
	#If the delay timer is done, goes to the next frame in the animation
	animation_delay_timer+=1
	if(animation_delay_timer>=current_animation_delays[animation_timer]):
		animation_timer+=1
		animation_delay_timer = 0
	if(animation_timer>=current_animation.size()): animation_timer = 0
	sprite.set_frame(current_animation[animation_timer])
	#This avoids pixel imprecisions when an entity moves a non-integer number of pixels
	sprite.set_global_pos(Vector2(round(get_global_pos().x),round(get_global_pos().y)))

#Fixed process method (for physics)
func _fixed_process(delta):
	#If the entity is moving, change position
	if (get_state() == cons.ST_MOVING):
		move(forward)

#Sets the state to the given value
func set_state(st):
	#Only changes state and animation if it's different from the current one
	if(state!=st):
		state = st
		#Animations are updated
		if(animations!=null): set_animation()

#Sets the direction to the given value
func set_direction(dir):
	#Only changes direction and animation if it's different from the current one
	if(direction!=dir):
		direction = dir
		#Animations are updated
		if(animations!=null): set_animation()
		#Updates the "forward" and "right" directions
		if (direction == cons.DR_UP):
			forward = Vector2(0,-1)
			right = Vector2(1,0)
		elif (direction == cons.DR_LEFT):
			forward = Vector2(-1,0)
			right = Vector2(0,-1)
		elif (direction == cons.DR_DOWN):
			forward = Vector2(0,1)
			right = Vector2(-1,0)
		elif (direction == cons.DR_RIGHT):
			forward = Vector2(1,0)
			right = Vector2(0,1)

#Returns the state
func get_state():
	return state

#Returns the direction
func get_direction():
	return direction

#Returns the vector pointing forward for this entity
func get_forward():
	return forward

#Returns the vector pointing right for this entity
func get_right():
	return right

#Sets both state and direction at once
func set_state_direction(st,dir):
	set_state(st)
	set_direction(dir)

#Moves forward, amount given by speed
func move(vect):
	.move(movement_speed*vect)


#Sets the current animation according to the state and direction, and resets the timer
func set_animation():
	current_animation = animations[state][direction][0]
	current_animation_delays = animations[state][direction][1]
	animation_timer = 0

#Sets the current animation, with the state and direction given
func set_given_animation(st,dir):
	current_animation = animations[st][dir][0]
	current_animation_delays = animations[st][dir][1]
	animation_timer = 0

#Sets a customized animation (mainly for the use of skills)
func set_custom_animation(anim,delays):
	current_animation = anim
	current_animation_delays = delays
	animation_timer = 0

#Checks if there is collision in the given direction (not needed just yet)
#func test_direction(vect):
#	return test_move(speed*vect)

#The same as test_move, but ignores any obstacles in the way
#func test_move_no_collision(vect):
#	print(is_colliding())
#	var ret
#	set_global_pos(get_global_pos()+vect)
#	ret = is_colliding()
#	print(is_colliding())
#	set_global_pos(get_global_pos()-vect)
#	return ret
	
	
