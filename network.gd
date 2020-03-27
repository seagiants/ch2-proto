extends Node

#Technical counter to handle the end of the shop scene
var _nb_player_ready_in_shop = 0

func _ready():
	pass

#Used to react both to shop signal and to client requests
remote func _on_player_ready_in_shop(new_player_state):
	_nb_player_ready_in_shop += 1
	#If it's not the current player, update playerstate, if it is just pause and wait other players
	if new_player_state.id != str(get_tree().get_network_unique_id()):
			print(new_player_state)
			GameState.get_player(new_player_state.id).update_from_json(new_player_state)
	else: 
			get_tree().paused = true
	#Server handle the switch to quest
	if get_tree().is_network_server():
		var players = GameState.get_players_json()
		if _nb_player_ready_in_shop == players.size():
			_nb_player_ready_in_shop = 0
			rpc('go_to_quest',players)
	#Client only informs server they're ready
	else:	
		rpc("_on_player_ready_in_shop",new_player_state)

func _on_game_created():
	GameState.generate_map(64,5)
	GameState.add_player(str(get_tree().get_network_unique_id()))

func _on_game_started():
	if get_tree().is_network_server():
		rpc("go_to_shop",GameState.get_players_json(),GameState.get_map())		

func _on_player_joined(player_id):
	if get_tree().is_network_server():
		GameState.add_player(str(player_id))

remotesync func go_to_quest(player_states):	
	print("go_to_quest")
	if not(get_tree().is_network_server()):
		print("not server")
		print(player_states)
		GameState.update_player_states(player_states)
	get_tree().paused = false
	var _changed = get_tree().change_scene("res://scenes/Quest/Quest.tscn")

remotesync func go_to_shop(player_states, map = null):	
	print("go_to_shop")
	if not(get_tree().is_network_server()):
		if map != null :
			GameState.set_map(map)
		print("not server")
		print(player_states)
		GameState.update_player_states(player_states)
	get_tree().paused = false
	var _changed = get_tree().change_scene("res://scenes/Shop/Shop.tscn")

