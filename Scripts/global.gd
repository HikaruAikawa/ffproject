extends Node

func get_player_class(id):
	return load("res://Scripts/PlayerClasses/player_class_"+str(id)+".gd")

func get_enemy_script(id):
	return load("res://Scripts/Enemies/enemy_"+str(id)+".gd")

func _ready():
	pass
