#Player of the class Night
extends "res://Scripts/player.gd"

#DEFINITION OF METHODS

func _ready():
	
	base_stats = [0,0,0,0,0]
	base_stats[HP]=100
	base_stats[MP]=50
	base_stats[ATK]=10
	base_stats[DEF]=20
	base_stats[SPD]=2
	
	current_stats = [0,0,0,0,0]
	for i in range(base_stats.size()):
		current_stats[i] = base_stats[i]
	current_hp = current_stats[HP]
	current_mp = current_stats[MP]
	
	#._ready()

func _process(delta):
	movement_speed = current_stats[SPD]