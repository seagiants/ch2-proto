extends Node2D

var map
var _players_on_map

signal quest_finished()

var _quest_log = []

func _ready():
	map = $Map
	map.init()
	map.connect("map_clicked",self,"on_map_clicked")
	_players_on_map = GameState.get_players_id()
#	for player_id in _players_on_map:
#		GameState.get_player(player_id).connect("player_stats_changed",self,"add_quest_log")
#	map.connect("loco_exited",self,"on_loco_exited")
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
		resolve_player_turn(player_id)

func resolve_player_turn(player_id):
	#Init vars
	var player = GameState.get_player(player_id)
	var start = map.get_loco_tile(player_id)
	var cell_type = start.type
	#Resolve player's abilities
	for ability in player.get_abilities(cell_type):
		AbilityLib.resolve_ability(ability,player)
	#Check if still work to do
	if not(player.is_advancing()):
		player.do_work()
		return false
	var next_move = player.get_next_move()
	#Ajout d'un move par défaut pour les tests principalement.
	if next_move == null :
		next_move = 0
#		print("Arrivé à la station")
	#Récupération de la position après move
	var pos_end = start.index + Vector2(1,next_move)
	#Vérifier que l'on peut avancer
	#1 - pas de boulot à faire
	var end_cell =  map.pos_to_name(pos_end)
	#2 - Personne sur la case destination
	if 	has_node(end_cell) and get_node(end_cell).content != null :
		return false	
	#Moving Loco on map
	map.move_loco(player_id,pos_end)
	#Updating playerState
	player.set_loco_position(pos_end)
	player.pop_next_move()
#	if map.advance_loco(player_id):
	var end = map.get_loco_tile(player_id)
	if end != null :
		cell_type = end.type
		for ability in GameState.get_cell_abilities(pos_end):
			AbilityLib.resolve_ability(ability,player)
		if end.type == "STATION":
			_players_on_map.erase(player_id)
			if _players_on_map.size() == 0:
				emit_signal("quest_finished")
