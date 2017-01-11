extends Node2D

#Auxiliary class
class EnemySpawn extends Node:
	var x
	var y
	var enemy
	var delay
	var spawned
	func get_x(): return x
	func get_y(): return y
	func get_enemy(): return enemy
	func get_delay(): return delay
	func is_spawned(): return spawned
	func set_x(x): self.x = x
	func set_y(y): self.y = y
	func set_enemy(enemy): self.enemy = enemy
	func set_delay(delay): self.delay = delay
	func set_spawned(is_spawned): spawned = is_spawned

#DEFINITION OF CONSTANTS

const MAX_PHASES = 20

#DEFINITION OF VARIABLES

var global

#The phase this spawner is currently at
var current_phase
#A dictionary of integers (the phase) to arrays of enemy spawns
var spawns
#A timer to control the spawning of enemies
var spawn_timer
#The enemy scene to instance enemies
var enemy_scn

func _ready():
	global = get_node("/root/global")
	enemy_scn = global.get_enemy_scene()
	current_phase = 0
	spawn_timer = 0
	#Initializes the list of spawns
	spawns = {}
	for i in range(0,MAX_PHASES):
		spawns[i] = []
	set_process(true)

func _process(delta):
	spawn_timer += delta
	for spawn in spawns[current_phase]:
		if (!spawn.is_spawned() && spawn_timer >= spawn.get_delay()):
			spawn_enemy(spawn.get_x(),spawn.get_y(),spawn.get_enemy())
			spawn.set_spawned(true)

#Creates a new enemy spawn in a given position 
func add_spawn(x,y,enemy,delay,phase):
	var spawn = EnemySpawn.new()
	spawn.set_x(x)
	spawn.set_y(y)
	spawn.set_enemy(enemy)
	spawn.set_delay(delay)
	spawns[phase].push_back(spawn)

#Creates an enemy node with the spawn data
func spawn_enemy(x,y,enemy):
	var e = enemy_scn.instance()
	e.set_script(global.get_enemy_script(enemy))
	e.set_global_pos(Vector2(x,y))
	add_child(e)
	e.set_owner(self)

#When the next phase starts, resets the timer
func next_phase():
	current_phase += 1
	spawn_timer = 0

#Returns true if all enemies on the current phase have been spawned
func all_enemies_spawned():
	for spawn in spawns[current_phase]:
		if (!spawn.is_spawned()): return false
	return true

func get_phase():
	return current_phase
