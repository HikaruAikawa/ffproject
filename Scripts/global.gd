extends Node

var current_scene

func _ready():
	var root = get_node("/root")
	current_scene = root.get_child(root.get_child_count()-1)

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

func get_skill_script(id):
	return load("res://Scripts/Skills/skill_"+str(id)+".gd")

func get_weapon_script(id):
	return load("res://Scripts/Weapons/weapon_"+str(id)+".gd")

#Changes the current scene when called
func change_scene(path): call_deferred("_deferred_change_scene",path)
func _deferred_change_scene(path):
	current_scene.free()
	current_scene = load(path).instance()
	get_node("/root").add_child(current_scene)
	get_tree().set_current_scene(current_scene)
