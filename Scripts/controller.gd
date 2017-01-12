#Player's controller
extends Node2D

#DEFINITION OF CONSTANTS

const ST_IDLE = 0
const ST_MOVING = 1
const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3
const PR_ANY = 0
const PR_PRESSED = 1
const PR_RELEASED = 2

#DEFINITION OF VARIABLES

var player
var player_number
var action_stack
var weapon

var debug = true

#DEFINITION OF SIGNALS

signal skill_0_button(pressed)
signal skill_1_button(pressed)

#DEFINITION OF METHODS

func _ready():
	#Gets the player and player number
	player = get_parent()
	player_number = str(player.get_player_number()+1)
	action_stack = []
	
	#Connects the skills at a later point, when the weapons have been initialized
	call_deferred("connect_skill",0,0)
	call_deferred("connect_skill",1,0)
	
	set_process(true)
	set_process_input(true)

func connect_skill(slot,sk_id):
	for other_sk in player.get_weapon(slot).get_skills():
		disconnect("skill_"+str(slot)+"_button",other_sk,"_button")
	var sk = player.get_weapon(slot).get_skill(sk_id)
	connect("skill_"+str(slot)+"_button",sk,"_button")

#Handles all inputs
func _input(event):
	var state = player.get_state()
	var direction = player.get_direction()
	
	#MOVEMENT INPUTS
#	if (event.is_action_pressed("gm_p"+player_number+"_up")): action_stack.push_front(DR_UP)
#	elif (event.is_action_pressed("gm_p"+player_number+"_left")): action_stack.push_front(DR_LEFT)
#	elif (event.is_action_pressed("gm_p"+player_number+"_down")): action_stack.push_front(DR_DOWN)
#	elif (event.is_action_pressed("gm_p"+player_number+"_right")): action_stack.push_front(DR_RIGHT)
#	elif (event.is_action_released("gm_p"+player_number+"_up")): action_stack.erase(DR_UP)
#	elif (event.is_action_released("gm_p"+player_number+"_left")): action_stack.erase(DR_LEFT)
#	elif (event.is_action_released("gm_p"+player_number+"_down")): action_stack.erase(DR_DOWN)
#	elif (event.is_action_released("gm_p"+player_number+"_right")): action_stack.erase(DR_RIGHT)

	if (is_event_action_pressed(event,"gm_p"+player_number+"_up")): action_stack.push_front(DR_UP)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_left")): action_stack.push_front(DR_LEFT)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_down")): action_stack.push_front(DR_DOWN)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_right")): action_stack.push_front(DR_RIGHT)
	elif (is_event_action_released(event,"gm_p"+player_number+"_up")): action_stack.erase(DR_UP)
	elif (is_event_action_released(event,"gm_p"+player_number+"_left")): action_stack.erase(DR_LEFT)
	elif (is_event_action_released(event,"gm_p"+player_number+"_down")): action_stack.erase(DR_DOWN)
	elif (is_event_action_released(event,"gm_p"+player_number+"_right")): action_stack.erase(DR_RIGHT)
	
	if (player.get_state() == ST_IDLE || player.get_state() == ST_MOVING):
		if (is_event_action_pressed(event,"gm_p"+player_number+"_skill_0")):
			#player.get_weapon(0).use_skill(0)
			emit_signal("skill_0_button",true)
		elif (is_event_action_pressed(event,"gm_p"+player_number+"_skill_1")):
			#player.get_weapon(1).use_skill(0)
			emit_signal("skill_1_button",true)
	
#	#DEBUGGING INPUTS
	if (debug):
		if (event.is_action("db_p"+player_number+"_reduce_health")):
			player.increase_hp(-1)
		elif (event.is_action("db_p"+player_number+"_increase_health")):
			get_tree().set_pause(true)

func _process(delta):
	if (player.get_state() == ST_IDLE || player.get_state() == ST_MOVING):
		if (action_stack.empty()): player.set_state(ST_IDLE)
		else: player.set_state_direction(ST_MOVING,action_stack[0])
	
	#This check allows the skills to be initialized after the weapons have been assigned
#	if (!skills_connected):
#		connect_skill(0,0)
#		connect_skill(1,0)

func is_event_action(event,action):
	if (event.type == InputEvent.KEY):
		var clearEvent = InputEvent(event)
		clearEvent.control = false
		clearEvent.alt = false
		clearEvent.shift = false
		return clearEvent.is_action(action)
	else:
		return event.is_action(action)

func is_event_action_pressed(event,action):
	if (event.type == InputEvent.KEY):
		var clearEvent = InputEvent(event)
		clearEvent.control = false
		clearEvent.alt = false
		clearEvent.shift = false
		return clearEvent.is_action_pressed(action)
	else:
		return event.is_action_pressed(action)

func is_event_action_released(event,action):
	if (event.type == InputEvent.KEY):
		var clearEvent = InputEvent(event)
		clearEvent.control = false
		clearEvent.alt = false
		clearEvent.shift = false
		return clearEvent.is_action_released(action)
	else:
		return event.is_action_released(action)