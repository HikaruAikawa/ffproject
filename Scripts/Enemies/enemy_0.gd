extends "res://Scripts/enemy.gd"

#CLASS METHODS

#static func get_hp(): return 30
#static func get_mp(): return 100
static func get_speed(): return 0.8
static func get_texture():
	return load("res://Textures/Enemies/enemy_0.tex")
static func get_base_stats():
	return {
		HP : 30,
		MP : 100,
		ATK : 15,
		DEF : 0,
		SPD : 0.8
	}