extends "res://Scripts/skill.gd"

var swing_scn = preload("res://Scenes/Swing.tscn")
var swing
var texture

func _init():
	mp_cost = 5
	cooldown = 2
	texture = preload("res://Textures/Weapons/Sword1.tex")

func _process(delta):
	pass

func effect():
	swing = swing_scn.instance()
	swing.initialize(user,texture,2,90,24)
	add_child(swing)
	swing.set_owner(self)