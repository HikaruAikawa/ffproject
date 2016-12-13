#Magic bar for players
extends Sprite

var player

func _ready():
	player = get_parent().get_parent()
	set_process(true)
	
func _process(delta):
	var magic = player.current_mp
	var max_magic = player.get_stat(player.MP)
	set_region_rect(Rect2(0,0,((1.0*magic)/max_magic)*32,32))