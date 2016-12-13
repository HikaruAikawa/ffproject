#extends Node2D
#
#var viewport
#var map
#
#func _ready():
#	viewport = get_viewport()
#	map = get_node("Map")
#	var rect = map.get_node("GameArea").get_shape(0)
#	viewport.set_rect(Rect2(Vector2(0,0),2*rect.get_extents()))
