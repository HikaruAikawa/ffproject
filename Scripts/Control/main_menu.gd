extends VBoxContainer

var start_game_button
var input_menu_button
var global

func _ready():
	global = get_node("/root/global")
	start_game_button = find_node("StartGameButton")
	start_game_button.connect("pressed",self,"_start_game")
	input_menu_button = find_node("InputMenuButton")
	input_menu_button.connect("pressed",self,"_input_menu")

func _start_game():
	global.change_scene("res://Scenes/Main.tscn")

func _input_menu():
	global.change_scene("res://Scenes/Control/InputMenu.tscn")
