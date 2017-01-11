extends "res://scripts/main.gd"

func _ready():
	
	#Players
	instantiate_player(0,config.get_player_class(0),32*14+16,32*8+16)
	if (config.player_number >= 2):
		instantiate_player(1,config.get_player_class(1),32*17+16,32*8+16)
	
	#Enemy spawners
	var spawner = new_enemy_spawner()
	spawner.add_spawn(32*1+16,32*1+16,0,0,0)
	spawner.add_spawn(32*30+16,32*1+16,0,5,0)
	spawner.add_spawn(32*5+16,32*8+16,0,0,1)
	var spawner = new_enemy_spawner()
	spawner.add_spawn(32*30+16,32*15+16,0,0,0)
	spawner.add_spawn(32*1+16,32*15+16,0,5,0)
	spawner.add_spawn(32*26+16,32*8+16,0,5,1)

func import_map():
	map_scn = global.get_map_scene(0)