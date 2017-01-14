#Player's controller
extends Node2D

#DEFINITION OF VARIABLES

var player
var player_number
var action_stack
var weapon
var selected_skill

var debug = false

#DEFINITION OF SIGNALS

signal attack_button(pressed)
signal skill_0_button(pressed)
signal skill_1_button(pressed)

#DEFINITION OF METHODS

func _ready():
	#Gets the player and player number
	player = get_parent()
	player_number = str(player.get_player_number()+1)
	action_stack = []
	
	#Connects the skills at a later point, when the weapons have been initialized
	selected_skill = [null,null]
	call_deferred("connect_attack")
	call_deferred("connect_skill",0,1)
	call_deferred("connect_skill",1,1)
	
	set_process(true)
	set_process_input(true)

func connect_skill(slot,sk_id):
	if (player.get_weapon(slot).is_skill_unlocked(sk_id)):
		if (selected_skill[slot] != null):
			var old_sk = player.get_weapon(slot).get_skill(selected_skill[slot])
			disconnect("skill_"+str(slot)+"_button",old_sk,"_button")
		var sk = player.get_weapon(slot).get_skill(sk_id)
		connect("skill_"+str(slot)+"_button",sk,"_button")
		selected_skill[slot] = sk_id

#The attack action always executes the first skill on the right-hand weapon
func connect_attack():
	var sk = player.get_weapon(0).get_skill(0)
	connect("attack_button",sk,"_button")

#Handles all inputs
func _input(event):
	var state = player.get_state()
	var direction = player.get_direction()
	
	#MOVEMENT INPUTS

	if (is_event_action_pressed(event,"gm_p"+player_number+"_up")): action_stack.push_front(cons.DR_UP)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_left")): action_stack.push_front(cons.DR_LEFT)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_down")): action_stack.push_front(cons.DR_DOWN)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_right")): action_stack.push_front(cons.DR_RIGHT)
	elif (is_event_action_released(event,"gm_p"+player_number+"_up")): action_stack.erase(cons.DR_UP)
	elif (is_event_action_released(event,"gm_p"+player_number+"_left")): action_stack.erase(cons.DR_LEFT)
	elif (is_event_action_released(event,"gm_p"+player_number+"_down")): action_stack.erase(cons.DR_DOWN)
	elif (is_event_action_released(event,"gm_p"+player_number+"_right")): action_stack.erase(cons.DR_RIGHT)
	
	#The attack action always executes the first skill on the right-hand weapon
	if (is_event_action_pressed(event,"gm_p"+player_number+"_attack")):
		emit_signal("attack_button",true)
	elif (is_event_action_released(event,"gm_p"+player_number+"_attack")):
		emit_signal("attack_button",false)
	
	if (is_event_action_pressed(event,"gm_p"+player_number+"_skill_0")):
		#player.get_weapon(0).use_skill(0)
		emit_signal("skill_0_button",true)
	elif (is_event_action_pressed(event,"gm_p"+player_number+"_skill_1")):
		#player.get_weapon(1).use_skill(0)
		emit_signal("skill_1_button",true)
	if (is_event_action_released(event,"gm_p"+player_number+"_skill_0")):
		#player.get_weapon(0).use_skill(0)
		emit_signal("skill_0_button",false)
	elif (is_event_action_released(event,"gm_p"+player_number+"_skill_1")):
		#player.get_weapon(1).use_skill(0)
		emit_signal("skill_1_button",false)
	
#	#DEBUGGING INPUTS
	if (debug):
		if (event.is_action("db_p"+player_number+"_reduce_health")):
			player.increase_hp(-1)
		elif (event.is_action("db_p"+player_number+"_increase_health")):
			get_tree().set_pause(true)

func _process(delta):
	if (player.get_state() == cons.ST_IDLE || player.get_state() == cons.ST_MOVING):
		if (action_stack.empty()): player.set_state(cons.ST_IDLE)
		else: player.set_state_direction(cons.ST_MOVING,action_stack[0])

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