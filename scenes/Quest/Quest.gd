extends Node2D

var map

func _ready():
	map = $Map
	map.init()
	map.connect("map_clicked",self,"on_map_clicked")

func on_map_clicked(_tile_index):
	for i in [0,1]:
		var start = map.get_loco_tile(i)
		var player = GameState.players[i]
		var cell_type = start.type
		for ability in player.get_abilities(cell_type):
			AbilityLib.resolve_ability(ability,player)
		map.advance_loco(i)
