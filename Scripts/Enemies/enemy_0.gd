extends "res://Scripts/enemy.gd"

#CLASS METHODS

static func get_hp(): return 20
static func get_mp(): return 100
static func get_speed(): return 0.8
static func get_texture():
	return load("res://Textures/Enemies/enemy_0.tex")
