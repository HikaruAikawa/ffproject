extends VBoxContainer

var start_game_button
var input_menu_button
var config_menu_button
var global

func _ready():
	global = get_node("/root/global")
	start_game_button = find_node("StartGameButton")
	start_game_button.connect("pressed",self,"_start_game")
	input_menu_button = find_node("InputMenuButton")
	input_menu_button.connect("pressed",self,"_input_menu")
	config_menu_button = find_node("ConfigMenuButton")
	config_menu_button.connect("pressed",self,"_config_menu")

func _start_game():
	global.set_stage(0)

func _input_menu():
	global.change_scene("res://Scenes/Control/InputMenu.tscn")

func _config_menu():
	global.change_scene("res://Scenes/Control/ConfigMenu.tscn")
