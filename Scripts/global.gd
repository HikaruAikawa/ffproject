extends Node

#Methods for importing packed scenes
func get_player_scene():
	return load("res://Scenes/Player.tscn")

func get_enemy_scene():
	return load("res://Scenes/Enemy.tscn")

func get_enemy_spawner_scene():
	return load("res://Scenes/EnemySpawner.tscn")

func get_map_scene(id):
	return load("res://Scenes/Maps/Map_"+str(id)+".tscn")

func get_weapon_scene():
	return load("res://Scenes/Weapon.tscn")

#Methods for importing scripts
func get_player_script(id):
	return load("res://Scripts/PlayerClasses/player_class_"+str(id)+".gd")

func get_enemy_script(id):
	return load("res://Scripts/Enemies/enemy_"+str(id)+".gd")

#func get_generic_enemy_script():
#	return load("res://Scripts/enemy.gd")

func get_skill_script(id):
	return load("res://Scripts/Skills/skill_"+str(id)+".gd")

func get_weapon_script(id):
	return load("res://Scripts/Weapons/weapon_"+str(id)+".gd")
