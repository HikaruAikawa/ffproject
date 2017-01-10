extends Node

var input_path

func _ready():
	input_path = "res://input.cfg"
	load_inputs()

func save_inputs():
	var input_file = ConfigFile.new()
	for action in InputMap.get_actions():
		if (action.begins_with("gm_") || action.begins_with("db_")):
			for event in InputMap.get_action_list(action):
				if (event.type == InputEvent.KEY):
					if (action.find("p1") != -1):
						input_file.set_value("p1",action,event.scancode)
					elif (action.find("p2") != -1):
						input_file.set_value("p2",action,event.scancode)
	var err = input_file.save(input_path)
	if (err == OK): return true
	else: return false

func load_inputs():
	var key_code
	var new_event
	var input_file = ConfigFile.new()
	var err = input_file.load(input_path)
	if (err == OK):
		for action in InputMap.get_actions():
			if (action.begins_with("gm_") || action.begins_with("db_")):
				for event in InputMap.get_action_list(action):
					if (event.type == InputEvent.KEY):
						InputMap.action_erase_event(action,event)
				if (action.find("p1") != -1):
					key_code = input_file.get_value("p1",action)
				elif (action.find("p2") != -1):
					key_code = input_file.get_value("p2",action)
				new_event = InputEvent()
				new_event.type = InputEvent.KEY
				new_event.scancode = key_code
				InputMap.action_add_event(action,new_event)
		return true
	else: return false
