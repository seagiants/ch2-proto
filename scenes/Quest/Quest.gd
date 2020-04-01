extends Node2D

var map
onready var _players_on_map = GameState.get_players_id()

signal quest_finished()

func _ready():
	map = $Map
	map.init()
	map.connect("map_clicked",self,"on_map_clicked")
	map.connect("loco_exited",self,"on_loco_exited")
	var _connect = self.connect("quest_finished",GameState,"on_quest_finished")
	
static func sort_by_power(a, b):
	if a.get_power() < b.get_power():
		return true	 
	return false
	
func on_map_clicked(_tile_index):
	var sorted_players = GameState.get_players()
	sorted_players.sort_custom(self,"sort_by_power") 
	for player in sorted_players:
		var player_id = player.get_name()
		if not(player_id in _players_on_map):
			return
		var start = map.get_loco_tile(player_id)
		var cell_type = start.type
		for ability in player.get_abilities(cell_type):
			AbilityLib.resolve_ability(ability,player)
		if map.advance_loco(player_id):
			var end = map.get_loco_tile(player_id)
			if end != null :
				cell_type = end.type
				for ability in map.get_abilities(cell_type):
					AbilityLib.resolve_ability(ability,player)

func on_loco_exited(p_id):
	_players_on_map.erase(p_id)
	if _players_on_map.size() == 0:
		emit_signal("quest_finished")
