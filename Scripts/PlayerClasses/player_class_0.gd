#Player of the class Night
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_id():
	return 0

static func get_name():
	return "Night"

static func get_base_stats():
	return {
		HP : 100,
		MP : 50,
		ATK : 10,
		DEF : 8,
		SPD : 2
	}

static func get_texture():
	return load("res://Textures/Characters/player_class_0.tex")