extends "res://Scripts/main.gd"

func _ready():
	
	#Enemy spawners
	var spawner = new_enemy_spawner()
	spawner.add_spawn(1,1,0,0,0)
	spawner.add_spawn(30,1,0,5,0)
	spawner.add_spawn(5,8,0,0,1)
	var spawner = new_enemy_spawner()
	spawner.add_spawn(30,15,0,0,0)
	spawner.add_spawn(1,15,0,5,0)
	spawner.add_spawn(26,8,0,5,1)
	pass

func import_map():
	map_scn = global.get_map_scene(0)

func get_player_spawns():
	return [Vector2(14,8),Vector2(17,8)]
	#return [Vector2(1,1),Vector2(17,8)]