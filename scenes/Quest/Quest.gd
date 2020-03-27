extends Node2D

var map

func _ready():
	map = $Map
	map.init()
	map.connect("map_clicked",self,"on_map_clicked")

func on_map_clicked(_tile_index):
	for player in GameState.get_players():
		var player_id = player.get_name()
		var start = map.get_loco_tile(player_id)
		var cell_type = start.type
		for ability in player.get_abilities(cell_type):
			AbilityLib.resolve_ability(ability,player)
		map.advance_loco(player_id)
