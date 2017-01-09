#Player of the class Night
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_id():
	return 0

static func get_name():
	return "Night"

static func get_base_stat(i):
	var base_stats = {
		HP : 100,
		MP : 50,
		ATK : 10,
		DEF : 20,
		SPD : 2
	}
	return base_stats[i]

static func get_texture():
	return load("res://Textures/Characters/player_class_0.tex")