extends Node2D

#DEFINITION OF VARIABLES

#The global singleton
var global
#The config singleton
var config

#Scenes to instantiate
var map_scn
var player_scn
var enemy_scn
var enemy_spawner_scn

#Nodes of the scene
var map
var players
var enemy_spawners

#Other variables
var current_phase

func _ready():
	#Saves the global and config nodes
	global = get_node("/root/global")
	config = get_node("/root/config")
	#Imports necessary scenes
	import_map()
	import_player()
	import_enemy_spawner()
	#Instantiates the map
	instantiate_map()
	#Instantiates the players
	players = {}
	#Instantiates the enemy spawners
	enemy_spawners = []
	current_phase = 0
	
	set_process(true)

func _process(delta):
	if (current_phase <= 1):
		if (should_advance()): next_phase()

func should_advance():
	for spawner in enemy_spawners:
		#Returns false if any of the spawners hasn't spawned all enemies, or still has children
		if (!spawner.all_enemies_spawned()): return false
		if (!spawner.get_children().empty()): return false
	#If it hasn't found a spawner that still has enemies, returns true
	return true

func next_phase():
	for spawner in enemy_spawners: spawner.next_phase()
	current_phase += 1

func import_player():
	player_scn = global.get_player_scene()

#func import_enemy():
#	enemy_scn = global.get_enemy_scene()

func import_enemy_spawner():
	enemy_spawner_scn = global.get_enemy_spawner_scene()

func instantiate_map():
	map = map_scn.instance()
	add_child(map)
	map.set_owner(self)
	map.set_name("Map")
	map.set_z(-10)

func instantiate_player(number, id, xpos, ypos):
	players[number] = player_scn.instance()
	players[number].set_script(global.get_player_script(id))
	players[number].set_player_number(number)
	players[number].set_name("Player "+str(number))
	add_child(players[number])
	players[number].set_owner(self)
	players[number].set_pos(Vector2(xpos,ypos))

func instantiate_enemy(id, xpos, ypos):
	enemy = enemy_scn.instance()
	enemy.set_script(global.get_enemy_script(id))
	add_child(enemy)
	enemy.set_owner(self)
	enemy.set_pos(Vector2(xpos,ypos))

func new_enemy_spawner():
	var ret = enemy_spawner_scn.instance()
	add_child(ret)
	ret.set_owner(self)
	enemy_spawners.append(ret)
	return ret

func remove_player(number):
	players[number] = null

func get_player_list():
	return players