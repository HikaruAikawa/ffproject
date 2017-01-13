#Player of the class Maige
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_id():
	return 1

static func get_name():
	return "Maige"

static func get_base_stats():
	return {
		HP : 100,
		MP : 100,
		ATK : 15,
		DEF : 2,
		SPD : 2.5
	}

#static func get_base_stat(i):
#	var base_stats = {
#		HP : 50,
#		MP : 100,
#		ATK : 15,
#		DEF : 5,
#		SPD : 2.5
#	}
#	return base_stats[i]

static func get_texture():
	return load("res://Textures/Characters/player_class_1.tex")