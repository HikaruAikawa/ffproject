extends "res://Scripts/skill.gd"

const ST_IDLE = 0
const ST_MOVING = 1
const ST_HURT = 2
const ST_SKILL = 3

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
	user.set_using_skill(0.2)
	swing = swing_scn.instance()
	swing.initialize(user,texture,0.2,PI/2,24)
	add_child(swing)
	swing.set_owner(self)
