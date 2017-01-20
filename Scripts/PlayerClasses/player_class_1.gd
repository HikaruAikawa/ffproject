#Player of the class Maige
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_id():
	return 1

static func get_name():
	return "Maige"

static func get_base_stats():
	return {
		cons.HP : 20,
		cons.MP : 50,
		cons.ATK : 15,
		cons.DEF : 5,
		cons.SPD : 2.5
	}

static func get_mp_regen():
	return 3

static func get_texture():
	return load("res://Textures/Characters/player_class_1.tex")