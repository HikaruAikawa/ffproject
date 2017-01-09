#Player of the class Maige
extends "res://Scripts/player.gd"

#CLASS METHODS

static func get_base_stat(i):
	var base_stats = {
		HP : 50,
		MP : 100,
		ATK : 15,
		DEF : 5,
		SPD : 2.5
	}
	return base_stats[i]

static func get_texture():
	return preload("res://Textures/Characters/player_class_1.tex")