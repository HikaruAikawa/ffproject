extends "res://Scripts/Enemies/enemy.gd"

#A timer to delay turning
var turn_timer
#Time it takes to turn, in seconds
var turn_time

func _ready():
	turn_time = 1
	turn_timer = turn_time

func _process(delta):
	#Increases the timer for turning
	if(turn_timer<turn_time): turn_timer += delta
	#If it hits a wall, ignores the timer and turns
	if(test_move(forward)): turn_timer = turn_time
	if (turn_timer >= turn_time):
		turn_timer = 0
		pick_direction()
	if (get_state() == cons.ST_IDLE): set_state(cons.ST_MOVING)

func pick_direction():
	set_direction(randi()%4)