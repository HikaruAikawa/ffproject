#Player of the class Maige
extends "res://Scripts/player.gd"

#DEFINITION OF METHODS

func _ready():
	
	base_stats = [0,0,0,0,0]
	base_stats[HP]=50
	base_stats[MP]=100
	base_stats[ATK]=15
	base_stats[DEF]=5
	base_stats[SPD]=2.5
	
	current_stats = [0,0,0,0,0]
	for i in range(base_stats.size()):
		current_stats[i] = base_stats[i]
	current_hp = current_stats[HP]
	current_mp = current_stats[MP]
	
	#._ready()

func _process(delta):
	movement_speed = current_stats[SPD]