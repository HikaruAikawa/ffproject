extends Node2D

var enemy_scn
var map_scn
var player_scn

var map
var player1
var player2
var enemy

func _ready():
	var player_class = preload("res://Scripts/player.gd")
	#Instantiates the map
	map = map_scn.instance()
	map.set_owner(self)
	map.set_name("Map")
	#Instantiates the players
	player1 = player_scn.instance()
	player1.set_owner(self)
	player1.set_player_number(1)
	player2 = player_scn.instance()
	player2.set_owner(self)
	player2.set_player_number(2)

func import_scenes():
	enemy_scn = preload("res://Scenes/Enemy.tscn")
	map_scn = preload("res://Scenes/Map.tscn")
	player_scn = preload("res://Scenes/Player.tscn")
