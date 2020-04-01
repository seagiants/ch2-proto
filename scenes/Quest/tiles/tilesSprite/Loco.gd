extends "res://scenes/Quest/tiles/tilesSprite/tileContent.gd"

var size = 2
var inside = []
var player_index

func _ready():
	pass

func init(index):
	player_index = index
	if(index != '1'):
		set_modulate(Color(0,0,1,1))
