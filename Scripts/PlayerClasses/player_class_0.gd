#Player of the class Night
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_id():
	return 0

static func get_name():
	return "Night"

static func get_base_stats():
	return {
		cons.HP : 20,
		cons.MP : 50,
		cons.ATK : 10,
		cons.DEF : 8,
		cons.SPD : 2
	}

static func get_texture():
	return load("res://Textures/Characters/player_class_0.tex")