extends Node

#Maximum of things allowed
const MAX_PLAYERS = 2
const MAX_CLASSES = 2
const MAX_WEAPONS = {
	0: [2,2],
	1: [2,2]
}

#Directions
const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3

#States
const ST_IDLE = 0
const ST_MOVING = 1
const ST_HURT = 2
const ST_SKILL = 3

#Stats
const HP = 0
const MP = 1
const ATK = 2
const DEF = 3
const SPD = 4
const MAX_STATS = 5

#Layers of bodies
const LYB_DEFAULT = 0
const LYB_WALLS = 1
const LYB_PLAYERS = 2
const LYB_ENEMIES = 3
const LYB_GAME_AREA = 4
#Layers of hitboxes
const LYH_PLAYERS = 10
const LYH_ENEMIES = 11
const LYH_PLAYER_ATTACKS = 12

const EPS = 0.5
