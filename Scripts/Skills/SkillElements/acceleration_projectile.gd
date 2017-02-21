extends "res://Scripts/Skills/SkillElements/projectile.gd"

var acceleration = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	movement_speed += acceleration

func set_acceleration(acceleration):
	self.acceleration = acceleration
