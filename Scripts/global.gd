extends Node

#Methods for importing packed scenes
func get_player_scene():
	return load("res://Scenes/Player.tscn")

func get_enemy_scene():
	return load("res://Scenes/Enemy.tscn")

func get_map_scene(id):
	return load("res://Scenes/Maps/Map_"+str(id)+".tscn")

#Methods for importing scripts
func get_player_script(id):
	return load("res://Scripts/PlayerClasses/player_class_"+str(id)+".gd")

func get_enemy_script(id):
	return load("res://Scripts/Enemies/enemy_"+str(id)+".gd")

func _ready():
	pass
