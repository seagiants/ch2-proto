extends Node
const PlayerState = preload("res://playerState.gd")
const Tiles = preload("res://scenes/Quest/tiles/tileFactory.gd")
const Network = preload("res://network.gd")
#y-step between players ways
const separation = 2
#Specific states for each player
#var players = []
#Map stored as [x][y] with tile_template
puppet var _map = [] setget set_map, get_map
#Turn counter
var _turn = 0 setget set_turn, get_turn
#Technical Counter to handle the end of the quest scene
#Todo : refactor => Mettre ailleurs, peut être géré au niveau de la scène ?
var _locos_exited = 0 setget set_locos_exited, get_locos_exited
#Technical counter to handle the end of the shop scene
var _nb_player_ready_in_shop = 0

#func init():
#	if get_tree().is_network_server() :		
#		generate_map(64,5)
#		print("Initmpap : %s" % _map.size())	
##		rpc("set_game_map",_map)
#		rset("_map",_map)
#	var player
#	for i in [0,1]:
#			player = PlayerState.new(i,Vector2(0,1+i*separation))
#			players.append(player)

func _ready():
	var network = Network.new()
	add_child(network)
	network.set_name("Network")

remotesync func set_game_map(map):
	_map = map

func get_players():
#	print(get_tree().get_nodes_in_group("PLAYERS"))
	return get_tree().get_nodes_in_group("PLAYERS")

func get_player(player_id):
	for player in get_players():
#		print(player.get_name())
#		print(player_id)
		if player.get_name() == str(player_id):
			return player
	#If no player matches
	return null

func add_player(player_id : String):
	var player_count = get_tree().get_nodes_in_group("PLAYERS").size()
	var player = PlayerState.new(player_count,Vector2(0,1+player_count*separation))
	add_child(player)
#	print("Adding :" + player_id)
#	print("Default_name:" + player.get_name())
	player.set_name(str(player_id))
#	print("Name setted :" + player.get_name())
	player.add_to_group("PLAYERS")

func set_map(nmap: Array):
	_map = nmap
	
func get_map():
	return _map

func add_loco_exited():
	set_locos_exited(get_locos_exited()+1)
	
func set_locos_exited(nb : int):
	_locos_exited = nb

func get_locos_exited():
	return _locos_exited

#From turn index to +8 on x, +1/-1 on y from the starting y
func get_current_map(is_preview =false):
	var player_id = get_tree().get_network_unique_id()
	#Used to start the map on x-axis
	var current_position = get_player(player_id).get_loco_position()
	#Used to limit the map on y-axis
	var start_position = get_player(player_id).get_starting_position()
#	var current_start = get_turn_step() * get_turn()
	var current_path_x = get_map().slice(current_position[0],current_position[0]+get_turn_step()-1)
	#If preview, need to slice on y-axis too, to limit at current-player's way
	if is_preview:
		var preview = []
		for i in current_path_x:
			preview.append(i.slice(start_position[1]-1,start_position[1]+1))
#		print(preview)
		return preview
	#If not preview, need to add the next_turn_path 
	else :
		var next_path = get_map().slice(current_position[0]+get_turn_step(),current_position[0]+2*get_turn_step()-1)
		return current_path_x +  next_path

func advance_turn():
	set_turn(get_turn()+1)
#	for player in get_players():
#		player.reinit_loco_position()

func get_turn_step():
	return 4

func set_turn(nturn: int):
	_turn = nturn

func get_turn():
	return _turn

func generate_map(h,v):
	_map = []
	var pool = Tiles.get_tiles(h*v)
	for i in range(h):
		var row = []
		_map.append(row)
		for j in range(v):
			var type
			if i % 4 == 0 :
#				print("Station: "+  str(i))
				type = "STATION"
			else:
				type = pool[i+j*h]
			var tile = {
				"type": type,
				"index": Vector2(i,j)
#				"index": str(i)+"x"+str(j)
			}
#			pool[i+j*h].index = str(i)+"x"+str(j)
#			row.append(pool[i+j*h])
			row.append(tile)
			
func draw_new_items(nb = 3):
	randomize()
	var draws = []
	var pools = ItemLib.get_pool()	
	for _i in range(nb):
		pools.shuffle()
		var draw = ItemLib.get_item_template(pools[0])
		draws.append(draw)	
	return draws

func draw_new_heroes(nb = 3):
	randomize()
	var draws = []
	var pools = HeroLib.get_pool()	
	for _i in range(nb):
		pools.shuffle()
		var draw = HeroLib.get_hero_template(pools[0])
		draws.append(draw)	
	return draws

# A path is just an array of y-move (-1 or 0 or 1) limited by -1/+1 from the stating pos
func draw_new_paths(player_id, length = 3, nb = 3):
	var paths = []
	randomize()
	#Path is just an array of y-move
#	var moves = [-1,0,1]
	#Define how much a player can move on y-axis during a turn (player separation) 
#	var amplitude_max = 1
	var player = get_player(player_id)
	#Retrieve y-coord of loco_position
	var current_position 
#	print(t)
#	var amplitude
	for _n in range(nb):
		current_position = player.get_loco_position() 
		var path = []
		paths.append(path)
		var avalaible_moves
#		print("move :")
		for _i in range(length):
			avalaible_moves = player.get_avalaible_moves(current_position)
##			if amplitude == amplitude_max:
#				avalaible_moves = moves.slice(0,1)
#			elif amplitude == -amplitude_max:
#				avalaible_moves = moves.slice(1,2)
#			else:
#				avalaible_moves = moves.duplicate()
			avalaible_moves.shuffle()
			var picked_move = avalaible_moves[0]
#			amplitude += picked_move
			path.append(picked_move)
			current_position = current_position + Vector2(1,picked_move)
#			print(str(avalaible_moves)+"->"+str(picked_move)+ ":"+str(amplitude))
	return paths

func on_loco_exited(_player_index):
	add_loco_exited()
#	print("exited : %s" % get_locos_exited())
	if get_locos_exited() == get_players().size():
		set_locos_exited(0)
		advance_turn()
		var _changed = get_tree().change_scene("res://scenes/Shop/Shop.tscn")

func update_player_states(player_states):
#	print("playerStates")
#	print(player_states)
	for	player_state in player_states:
#		var player = get_player(player_state.id)
		if get_player(player_state.id) == null:
			add_player(player_state.id)
		get_player(player_state.id).update_from_json(player_state)		

func get_players_json():
	var player_states = get_players()
	var json_states = []
	for player in player_states:
		json_states.append(player.player_state_to_json())
	return json_states
