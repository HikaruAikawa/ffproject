extends "res://scripts/main.gd"

func _ready():
	
	#Players
#	instantiate_player(0,config.get_player_class(0),32*14+16,32*8+16)
#	if (config.player_number >= 2):
#		instantiate_player(1,config.get_player_class(1),32*17+16,32*8+16)
	
	#Enemy spawners
	var spawner = new_enemy_spawner()
	spawner.add_spawn(1,1,0,0,0)
	spawner.add_spawn(30,1,0,5,0)
	spawner.add_spawn(5,8,0,0,1)
	var spawner = new_enemy_spawner()
	spawner.add_spawn(30,15,0,0,0)
	spawner.add_spawn(1,15,0,5,0)
	spawner.add_spawn(26,8,0,5,1)

func import_map():
	map_scn = global.get_map_scene(0)

func get_player_spawns():
	return [Vector2(14,8),Vector2(17,8)]