#Player of the class Night
extends "res://Scripts/player.gd"

#CLASS METHODS

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
	return preload("res://Textures/Characters/Night.tex")