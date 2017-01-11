extends VBoxContainer

#DEFINITION OF CONSTANTS

const MAX_PLAYERS = 2

#DEFINITION OF VARIABLES

#Variables for on-screen menu items
var message_label
var save_button
var scale_map
var scale_c
var player_number_c

var config

func _ready():
	config = get_node("/root/config")
	#Saves the message label and save button
	message_label = find_node("MessageLabel")
	save_button = find_node("SaveButton")
	save_button.connect("pressed",self,"_save_button_pressed")
	
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
	for i in range(0,MAX_PLAYERS):
		option_button.add_item(str(i+1),i)
	option_button.select(config.player_number-1)
	option_button.connect("item_selected",self,"_player_number_changed")

func _save_button_pressed():
	var config = get_node("/root/config")
	var file = ConfigFile.new()
	var val
	
	#Scale
	val = scale_map[scale_c.find_node("OptionButton").get_selected_ID()]
	file.set_value("General", "WindowScale", val)
	
	#Player number
	val = player_number_c.find_node("OptionButton").get_selected_ID() + 1
	file.set_value("Game", "PlayerNumber", val)
	
	if (config.save_config(file)):
		message_label.set_text("Configuration saved successfully")
	else: message_label.set_text("Error saving configuration")

func _scale_changed(item):
	config.set_window_scale(scale_map[scale_c.find_node("OptionButton").get_selected_ID()])

func _player_number_changed(item):
	config.set_player_number(player_number_c.find_node("OptionButton").get_selected_ID() + 1)

func find_key(dict,value):
	for i in dict.keys():
		if (dict[i] == value): return i