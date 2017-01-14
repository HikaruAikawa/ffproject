extends "res://Scripts/enemy.gd"

#CLASS METHODS

static func get_texture():
	return load("res://Textures/Enemies/enemy_0.tex")
static func get_base_stats():
	return {
		cons.HP : 30,
		cons.MP : 100,
		cons.ATK : 15,
		cons.DEF : 0,
		cons.SPD : 0.8
	}