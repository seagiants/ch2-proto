extends Node
const PlayerState = preload("res://playerState.gd")
const Tiles = preload("res://scenes/Quest/tiles/tileFactory.gd")
#y-step between players ways
const separation = 2
#Specific states for each player
var players = []
#Map stored as [x][y] with tile_template
var _map = [] setget set_map, get_map
#Turn counter
var _turn = 0 setget set_turn, get_turn
var _locos_exited = 0 setget set_locos_exited, get_locos_exited

func _init():
	var player
	generate_map(64,5)
#	print("Initmpap : %s" % _map.size())
	for i in [0,1]:
		player = PlayerState.new(i,Vector2(0,1+i*separation))
		players.append(player)

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

#From turn index to +8 on x, +2/-2 on y
func get_current_map(is_preview =false):
	var current_start = get_turn_step() * get_turn()
	var current_path = get_map().slice(current_start,current_start+get_turn_step()-1)
	if is_preview:
		var preview = []
		for i in current_path:
			preview.append(i.slice(0,2))
		return preview
	else :
		var next_path = get_map().slice(current_start+get_turn_step(),current_start+2*get_turn_step()-1)
		var stations = []
		for i in current_path[0].size():
			stations.append({"type":"STATION"})
	#		print(current_path + stations + next_path)
		return current_path + [stations] + next_path

func advance_turn():
	set_turn(get_turn()+1)
	for player in players:
		player.reinit_loco_position()

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
			var tile = {
				"type": pool[i+j*h],
				"index": str(i)+"x"+str(j)
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
func draw_new_paths(length = 3, nb = 3):
	var player_index = 0
	var paths = []
	randomize()
	var moves = [-1,0,1]
	var amplitude
	var t = GameState.players[0].get_loco_position()[1]
#	print(t)
	for _n in range(nb):
		amplitude = t - player_index -1
		var path = []
		paths.append(path)
		var avalaible_moves
#		print("move :")
		for _i in range(length):
			if amplitude == 1:
				avalaible_moves = moves.slice(0,1)
			elif amplitude == -1:
				avalaible_moves = moves.slice(1,2)
			else:
				avalaible_moves = moves.duplicate()
			avalaible_moves.shuffle()
			var picked_move = avalaible_moves[0]
			amplitude += picked_move
			path.append(picked_move)
#			print(str(avalaible_moves)+"->"+str(picked_move)+ ":"+str(amplitude))
	return paths

func on_loco_exited(_player_index):
	add_loco_exited()
#	print("exited : %s" % get_locos_exited())
	if get_locos_exited() == players.size():
		set_locos_exited(0)
		advance_turn()
		var _changed = get_tree().change_scene("res://scenes/Shop/Shop.tscn")
				
