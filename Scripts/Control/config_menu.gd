extends VBoxContainer

#DEFINITION OF VARIABLES

#Variables for on-screen menu items
var message_label
var save_button
var back_button
var scale_c
var player_number_c
var player_classes_c
var player_classes_c_list
var player_weapons_c
var player_weapons_c_list

#Other variables
var scale_map
var config
var global

func _ready():
	
	config = get_node("/root/config")
	global = get_node("/root/global")
	
	#Saves the message label and save and back buttons
	message_label = find_node("MessageLabel")
	save_button = find_node("SaveButton")
	save_button.connect("pressed",self,"_save_button_pressed")
	back_button = find_node("BackButton")
	back_button.connect("pressed",self,"_back_button_pressed")
	
	#Gets the menu item for the screen scale
	scale_c = find_node("ScaleC")
	#This identifies IDs in the option button with scales
	scale_map = {
		0:	1,
		1:	0.75,
		2:	1.25
	}
	#All options are added to the option button
	var option_button = scale_c.find_node("OptionButton")
	for i in scale_map.keys():
		var s = scale_map[i]
		option_button.add_item(str(s),i)
	option_button.select(find_key(scale_map,config.window_scale))
	option_button.connect("item_selected",self,"_scale_changed")
	
	#Gets the menu item for the number of players
	player_number_c = find_node("PlayerNumberC")
	option_button = player_number_c.find_node("OptionButton")
	for i in range(0,config.MAX_PLAYERS):
		option_button.add_item(str(i+1),i)
	option_button.select(config.player_number-1)
	option_button.connect("item_selected",self,"_player_number_changed")
	
	#Gets the menu item for the class of each player
	player_classes_c = find_node("PlayerClassesC")
	player_classes_c_list = []
	var player_c
	var player_label
	var player_button
	for i in range(0,config.MAX_PLAYERS):
		#For each player, creates the container
		player_c = VBoxContainer.new()
		player_classes_c.add_child(player_c)
		player_c.set_h_size_flags(SIZE_EXPAND)
		player_c.set_name("Player"+str(i)+"ClassC")
		#Creates the label with each player number
		player_label = Label.new()
		player_c.add_child(player_label)
		player_label.set_text("Player "+str(i+1))
		#Creates the button to choose from the classes
		player_button = OptionButton.new()
		player_c.add_child(player_button)
		player_button.set_name("OptionButton")
		for j in range(0,config.MAX_CLASSES):
			player_button.add_item(global.get_player_script(j).get_name(),j)
			#If the class coincides, mark it as selected
			if (config.get_player_class(i) == j): player_button.select(j)
		player_button.connect("item_selected",self,"_player_class_selected",[i])
		#Adds the container to the list
		player_classes_c_list.append(player_c)
	
	#Gets the menu item for the weapons of each player
	player_weapons_c = find_node("PlayerWeaponsC")
	player_weapons_c_list = []
	var weapons_list
	for i in range(config.MAX_PLAYERS):
		#For each player, creates the container
		player_c = VBoxContainer.new()
		player_weapons_c.add_child(player_c)
		player_c.set_h_size_flags(SIZE_EXPAND)
		player_c.set_name("Player"+str(i)+"ClassC")
		#For each hand, creates a right hand and a left hand buttons
		for k in range(0,2):
			#Creates the label for each hand
			player_label = Label.new()
			player_c.add_child(player_label)
			if (k == 0): player_label.set_text("Right hand")
			else: player_label.set_text("Left hand")
			#Creates the button to choose from the weapons
			player_button = OptionButton.new()
			player_c.add_child(player_button)
			player_button.set_owner(player_c)
			player_button.set_name("OptionButton"+str(k))
		player_weapons_c_list.append(player_c)
	
	update_player_classes()
	update_weapon_button_options()

func _save_button_pressed():
	var file = ConfigFile.new()
	var val
	
	#Scale
	val = scale_map[scale_c.find_node("OptionButton").get_selected_ID()]
	file.set_value("General", "WindowScale", val)
	
	#Player number
	val = player_number_c.find_node("OptionButton").get_selected_ID() + 1
	file.set_value("Game", "PlayerNumber", val)
	
	#Player classes
	for i in range(config.MAX_PLAYERS):
		var container = player_classes_c.find_node("Player"+str(i)+"ClassC",true,false)
		val = container.find_node("OptionButton",true,false).get_selected_ID()
		file.set_value("Game", "Player"+str(i)+"Class", val)
	
	#Player weapons
	for i in range(config.MAX_PLAYERS):
		val = player_weapons_c_list[i].find_node("OptionButton0",true,false).get_selected_ID()
		file.set_value("Game", "Player"+str(i)+"WeaponR", val)
		val = player_weapons_c_list[i].find_node("OptionButton1",true,false).get_selected_ID()
		file.set_value("Game", "Player"+str(i)+"WeaponL", val)
	
	#Saves the file
	if (config.save_config(file)):
		message_label.set_text("File saved successfully")
	else: message_label.set_text("Error saving configuration")

func _back_button_pressed():
	global.change_scene("res://Scenes/Control/MainMenu.tscn")

#Functions called dynamically when an item from an option button is changed
func _scale_changed(item):
	config.set_window_scale(scale_map[scale_c.find_node("OptionButton").get_selected_ID()])

func _player_number_changed(item):
	config.set_player_number(player_number_c.find_node("OptionButton").get_selected_ID() + 1)
	update_player_classes()

func update_player_classes():
	for i in range(config.MAX_PLAYERS):
		if (i>=config.get_player_number()):
			player_classes_c_list[i].set_hidden(true)
			player_weapons_c_list[i].set_hidden(true)
		else:
			player_classes_c_list[i].set_hidden(false)
			player_weapons_c_list[i].set_hidden(false)

func update_weapon_button_options():
	player_weapons_c_list
	var button
	var weapons_list
	for i in range(config.MAX_PLAYERS):
		for k in range(0,2):
			weapons_list = global.get_weapon_script_list(config.get_player_class(i),k)
			button = player_weapons_c_list[i].find_node("OptionButton"+str(k))
			button.clear()
			for w in weapons_list:
				button.add_item(w.get_name(),w.get_id())

func _player_class_selected(item,number):
	config.set_player_class(number,item)
	update_weapon_button_options()

#Auxiliary function
func find_key(dict,value):
	for i in dict.keys():
		if (dict[i] == value): return i