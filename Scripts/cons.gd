extends Node

const MAX_PLAYERS = 2
const MAX_CLASSES = 2
const MAX_WEAPONS = {
	0: [2,2],
	1: [2,2]
}

const DR_UP = 0
const DR_LEFT = 1
const DR_DOWN = 2
const DR_RIGHT = 3

const ST_IDLE = 0
const ST_MOVING = 1
const ST_HURT = 2
const ST_SKILL = 3

const HP = 0
const MP = 1
const ATK = 2
const DEF = 3
const SPD = 4
const MAX_STATS = 5

const EPS = 0.5
