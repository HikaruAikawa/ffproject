extends Node

#DEFINITION OF VARIABLES

#Paths to find the files
var input_path
var config_path

#Configuration variables
var original_size
var window_scale
var player_number

#DEFINITION OF METHODS

func _ready():
	input_path = "res://input.cfg"
	config_path = "res://config.cfg"
	original_size = OS.get_window_size()
	window_scale = 1
	load_inputs()
	load_config()

#Instead of receiving the file as an argument, it saves directly from the input map
#(Only the actions that start with gm_ (game) or db_ (debug))
func save_inputs():
	var file = ConfigFile.new()
	for action in InputMap.get_actions():
		if (action.begins_with("gm_") || action.begins_with("db_")):
			for event in InputMap.get_action_list(action):
				if (event.type == InputEvent.KEY):
					if (action.find("p1") != -1):
						file.set_value("p1",action,event.scancode)
					elif (action.find("p2") != -1):
						file.set_value("p2",action,event.scancode)
	var err = file.save(input_path)
	if (err == OK): return true
	else: return false

#Loads the data from the file directly into the input map
func load_inputs():
	var key_code
	var new_event
	var file = ConfigFile.new()
	var err = file.load(input_path)
	if (err == OK):
		for action in InputMap.get_actions():
			if (action.begins_with("gm_") || action.begins_with("db_")):
				#For each action, deletes all previous keyboard events
				for event in InputMap.get_action_list(action):
					if (event.type == InputEvent.KEY):
						InputMap.action_erase_event(action,event)
				#Then saves the keyboard event found in the file
				if (action.find("p1") != -1):
					key_code = file.get_value("p1",action)
				elif (action.find("p2") != -1):
					key_code = file.get_value("p2",action)
				new_event = InputEvent()
				new_event.type = InputEvent.KEY
				new_event.scancode = key_code
				InputMap.action_add_event(action,new_event)
		return true
	else: return false

#Takes the file passed as an argument and saves it as config.cfg
func save_config(file):
	var err = file.save(config_path)
	if (err == OK): return true
	else: return false

#Loads the values of the configuration variables from the file
func load_config():
	var file = ConfigFile.new()
	var err = file.load(config_path)
	if (err == OK):
		set_window_scale(file.get_value("General","WindowScale", 1))
		player_number = file.get_value("Game","PlayerNumber",1)
		return true
	else: return false

func set_window_scale(scale):
	window_scale = scale
	OS.set_window_size(original_size * window_scale)