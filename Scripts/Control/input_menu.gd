extends VBoxContainer

var button_list
var listening
var listening_action
var message_label

func _ready():
	button_list = []
	var container
	var label
	var button
	var event_list
	
	message_label = Label.new()
	add_child(message_label)
	message_label.set_owner(self)
	message_label.set_align(ALIGN_CENTER)
	message_label.set_text("Press a button to change the input key")
	
	var actions = InputMap.get_actions()
	actions.sort()
	for action in actions:
		if (action.begins_with("gm_")):
			container = HBoxContainer.new()
			add_child(container)
			container.set_owner(self)
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
	set_process_input(true)
	listening = false

func _action_button_pressed(action):
	if (!listening):
		message_label.set_text("Press any key")
		listening = true
		listening_action = action

func _input(event):
	if (listening):
		if (event.type == InputEvent.KEY):
			for other_event in InputMap.get_action_list(listening_action):
				if (other_event.type == InputEvent.KEY):
					InputMap.action_erase_event(listening_action,other_event)
			InputMap.action_add_event(listening_action,event)
			listening = false
			message_label.set_text("Press a button to change the input key")
			update_buttons()

func update_buttons():
	for button in button_list:
		var action = button.get_name().right(7)
		for event in InputMap.get_action_list(action):
			if (event.type == InputEvent.KEY):
				button.set_text(OS.get_scancode_string(event.scancode))