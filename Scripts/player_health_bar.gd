#Health bar for players
extends Sprite

var player

func _ready():
	player = get_parent().get_parent()
	set_process(true)
	
func _process(delta):
	var health = player.current_hp
	var max_health = player.get_stat(cons.HP)
	set_region_rect(Rect2(0,0,((1.0*health)/max_health)*32,32))