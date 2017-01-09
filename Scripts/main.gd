extends Node2D

#DEFINITION OF CONSTANTS

const CL_NIGHT = 0
const CL_MAIGE = 1

#DEFINITION OF VARIABLES

#Scenes to instantiate
var map_scn
var players_scn
var enemies_scn

var map
var players
var enemy

func _ready():
	#Imports necessary scenes
	import_map()
	import_players()
	import_enemies()
	#Instantiates the map
	instantiate_map()
	#Instantiates the players
	players = {}
	instantiate_player(1,CL_NIGHT,32*14+16,32*8+16)
	instantiate_player(2,CL_MAIGE,32*17+16,32*8+16)
	#Instantiates the enemy
	instantiate_enemy(0,32*1+16,32*1+16)

func import_map():
	map_scn = preload("res://Scenes/Map.tscn")

func import_players():
	players_scn = {}
	players_scn[CL_NIGHT] = preload("res://Scenes/PlayerClasses/PlayerClass_0.tscn")
	players_scn[CL_MAIGE] = preload("res://Scenes/PlayerClasses/PlayerClass_1.tscn")

func import_enemies():
	enemies_scn = {}
	enemies_scn[0] = preload("res://Scenes/Enemy.tscn")

func instantiate_map():
	map = map_scn.instance()
	add_child(map)
	map.set_owner(self)
	map.set_name("Map")
	map.set_z(-10)

func instantiate_player(number, cl, xpos, ypos):
	players[number] = players_scn[cl].instance()
	players[number].set_player_number(number)
	add_child(players[number])
	players[number].set_owner(self)
	players[number].set_pos(Vector2(xpos,ypos))

func instantiate_enemy(number, xpos, ypos):
	enemy = enemies_scn[number].instance()
	add_child(enemy)
	enemy.set_owner(self)
	enemy.set_pos(Vector2(xpos,ypos))
