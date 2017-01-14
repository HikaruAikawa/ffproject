extends VBoxContainer

#The list of buttons for all actions
var button_list
#Whether or not the menu is listening for a new key, and which action it will be assigned to
var listening
var listening_action
#The message displayed at the top
var message_label
#Buttons for saving and going back to the main menu
var save_button
var back_button

func _ready():
	button_list = []
	var container
	var label
	var button
	var event_list
	
	message_label = find_node("MessageLabel")
	message_label.set_text("Press a button to change the input key")
	
	var global = get_node("/root/global")
	
	var input_container = find_node("InputContainer")
	var p_input_containers = []
	for i in range(0,cons.MAX_PLAYERS):
		p_input_containers.append(VBoxContainer.new())
		p_input_containers[i].set_h_size_flags(SIZE_EXPAND_FILL)
		input_container.add_child(p_input_containers[i])
		var p_label = Label.new()
		p_input_containers[i].add_child(p_label)
		p_label.set_text("Player "+str(i+1))
		p_label.set_align(ALIGN_CENTER)
	
	var actions = InputMap.get_actions()
	actions.sort()
	for action in actions:
		#if (action.begins_with("gm_") || action.begins_with("db_")):
		if (action.begins_with("gm_")):
			container = HBoxContainer.new()
			var current_p_container
			current_p_container = p_input_containers[int(action.left(5).right(1))-1]
			current_p_container.add_child(container)
			container.set_owner(current_p_container)
			container.set_v_size_flags(SIZE_EXPAND)
			container.set_alignment(ALIGN_CENTER)
			
			label = Label.new()
			label.set_text(action)
			container.add_child(label)
			label.set_owner(container)
			
			button = Button.new()
			container.add_child(button)
			button.set_owner(container)
			button.set_name("button_"+action)
			button_list.append(button)
			
			event_list = InputMap.get_action_list(action)
			for event in event_list:
				if (event.type == InputEvent.KEY):
					button.set_text(OS.get_scancode_string(event.scancode))
			
			button.connect("pressed",self,"_action_button_pressed",[action])
	
	update_buttons()
	
	save_button = find_node("SaveButton")
	save_button.connect("pressed",self,"_save_button_pressed")
	back_button = find_node("BackButton")
	back_button.connect("pressed",self,"_back_button_pressed")
	
	set_process_input(true)
	listening = false

func _action_button_pressed(action):
	if (!listening):
		message_label.set_text("Press any key to bind it, ESC to remove it")
		listening = true
		listening_action = action

func _input(event):
	#Only handles the input if the user has pressed a button
	if (listening):
		var isValid = true
		if (event.type == InputEvent.KEY):
			#The key won't be valid if it's already in use
			for other_action in InputMap.get_actions():
				if (InputMap.action_has_event(other_action,event) && other_action.begins_with("gm_")):
					isValid = false
			if (isValid):
				#Erases all other events of the type key assigned to that action
				for other_event in InputMap.get_action_list(listening_action):
					if (other_event.type == InputEvent.KEY):
						InputMap.action_erase_event(listening_action,other_event)
				#If Escape is pressed, leaves the key blank
				if (event.scancode == OS.find_scancode_from_string("Escape")):
					message_label.set_text("The selected key has been removed")
				#If something else is pressed, assigns it
				else:
					InputMap.action_add_event(listening_action,event)
					message_label.set_text("The selected key has been changed")
			else:
				message_label.set_text("That key is already in use")
			listening = false
			update_buttons()

func update_buttons():
	for button in button_list:
		var action = button.get_name().right(7)
		var found = false
		for event in InputMap.get_action_list(action):
			if (event.type == InputEvent.KEY):
				found = true
				button.set_text(OS.get_scancode_string(event.scancode))
		if (!found):
			button.set_text("(Empty)")

func _save_button_pressed():
	var config = get_node("/root/config")
	if (config.save_inputs()): message_label.set_text("File saved successfully")
	else: message_label.set_text("Error saving file")

func _back_button_pressed():
	get_node("/root/global").change_scene("res://Scenes/Control/MainMenu.tscn")
