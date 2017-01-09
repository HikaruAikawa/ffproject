#Player's controller

#DEFINITION OF CONSTANTS

const ST_IDLE = 0
const ST_MOVING = 1
const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3

#DEFINITION OF VARIABLES

var player
var player_number
var action_stack

func _ready():
	#Gets the player and player number
	player = get_parent()
	player_number = String(player.get_player_number())
	action_stack = []
	set_process_input(true)

#Handles all inputs
func _input(event):
	var state = player.get_state()
	var direction = player.get_direction()
	
	#MOVEMENT INPUTS
	if (event.is_action_pressed("gm_p"+player_number+"_up")): 
		action_stack.push_front(DR_UP)
	elif (event.is_action_pressed("gm_p"+player_number+"_left")): action_stack.push_front(DR_LEFT)
	elif (event.is_action_pressed("gm_p"+player_number+"_down")): action_stack.push_front(DR_DOWN)
	elif (event.is_action_pressed("gm_p"+player_number+"_right")): action_stack.push_front(DR_RIGHT)
	elif (event.is_action_released("gm_p"+player_number+"_up")): action_stack.erase(DR_UP)
	elif (event.is_action_released("gm_p"+player_number+"_left")): action_stack.erase(DR_LEFT)
	elif (event.is_action_released("gm_p"+player_number+"_down")): action_stack.erase(DR_DOWN)
	elif (event.is_action_released("gm_p"+player_number+"_right")): action_stack.erase(DR_RIGHT)
	
	if (player.get_state() == ST_IDLE || player.get_state() == ST_MOVING):
		if (action_stack.empty()): player.set_state(ST_IDLE)
		else: player.set_state_direction(ST_MOVING,action_stack[0])
		
		if (event.is_action_pressed("db_p"+player_number+"_skill")):
			player.skill.use()
			get_tree().set_input_as_handled()
	
#	#DEBUGGING INPUTS
	if (event.is_action("db_p"+player_number+"_reduce_health")):
		player.increase_hp(-1)
	elif (event.is_action("db_p"+player_number+"_increase_health")):
		player.increase_hp(1)
	