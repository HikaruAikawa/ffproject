extends VBoxContainer

var button_list

func _ready():
	button_list = []
	var container
	var label
	var button
	var event_list
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
			
			event_list = InputMap.get_action_list(action)
			for event in event_list:
				if (event.type == InputEvent.KEY):
					button.set_text(OS.get_scancode_string(event.scancode))
	
