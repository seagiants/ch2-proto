extends Control
const Tile = preload("res://scenes/Quest/tiles/tile.gd")
const Loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn")

#signal loco_exited(player_index)
signal map_clicked(tile_index)

#Used to retrieve picked path in pathShop
var index = 0
#To refactor : à consolider avec les conditions des abilités côté héros, là c'est quick&dirty
#var abilities = {
#	"MOUNTAIN" : [{"ability_name":"working","atts":{}}]
#}


func init():	
#	var length = 4
	init_map(GameState.get_current_map())
	for player in GameState.get_players() :
		init_loco(player.get_name())
		init_rails(player.get_name())

func preview():
	var npreview = GameState.get_current_map(true) 
	init_map(npreview,true)

func init_loco(player_id):
	var loco = Loco.instance()
#	var pos = Vector2(GameState.get_turn(),1 + GameState.separation*player_index)
	var pos = GameState.get_player(player_id).get_loco_position()
	loco.init(player_id)
#	GameState.players[player_index].set_loco_position(pos)
	get_node(pos_to_name(pos)).add_content(loco)

func init_map(map : Array, _is_preview = false):
#	var _connect = self.connect("loco_exited",GameState,"on_loco_exited")
#	print("Mapsize : %s" % map.size())	
	for i in map.size():
		for j in map[i].size():
			var template = map[i][j]
			var pos = Vector2(i,j)
			var cell = Tile.new(template,pos)
			add_child(cell)
			cell.set_name(pos_to_name(template.index))
			cell.connect("tile_clicked",self,"on_tile_clicked")
			#Used to show the path // doesn't render well
#			if is_preview:
#				cell.modulate = Color(0,0,0,0.85)

func init_rails(player_id, path =null):
	if path == null :
		path = GameState.get_player(player_id).get_path()
	var cells = []
	var next = GameState.get_player(player_id).get_loco_position() 
	cells.append(next)
	for move in path:
		next = next + Vector2(1,move)
		cells.append(next)
	for cell in cells:
#		pass
		var tile = get_node(pos_to_name(cell)) 
		tile.add_rail()
		#preview on path should be enhanced.
#		tile.modulate = Color(1,1,1,1)
		
func pos_to_name(pos: Vector2):
	var text = str(pos[0])+"x"+str(pos[1]) 
	return text

func on_tile_clicked(_ctile):	
	emit_signal("map_clicked",index)

func get_loco_tile(player_index):
	var start = GameState.get_player(player_index).get_loco_position()
	var out = get_node(pos_to_name(start)) 
	return out
	
func move_loco(player_id,pos):
	#Failover if dest cell is not on map
	if not(has_node(pos_to_name(pos))):
		print("Trying to move loco %s to inexistant position (%s)" % player_id, pos)
		return false		
	var start = get_loco_tile(player_id)
	var loco = start.content
	start.remove_child(loco)
	start.remove_from_group("Loco")
	start.content = null
	var end = get_node(pos_to_name(pos))
	end.add_content(loco)
	return true


##To refactor : A consolider avec le get_abilities côté playerState
#func get_abilities(cell_type):
#	if cell_type in abilities.keys():
#		return abilities[cell_type]
#	else:
#		return []
	
##To refactor, dans le GameState ou playerState. Ici devrait y avoir que la partie bouger un icone de Loco.
#func advance_loco(player_id):
#	var start = get_loco_tile(player_id)
#	var player = GameState.get_player(player_id) 
#	if not(player.is_advancing()):
#		player.do_work()
#		return false
#	#Pas de position pour la loco = loco exited (à améliorer)
##	if start == null :
##		return false
##	var loco = start.content
#	var next_move = player.get_next_move()
#	#Ajout d'un move par défaut pour les tests principalement.
#	if next_move == null :
#		next_move = 0
##		print("Arrivé à la station")
#	#Récupération de la position après move
#	var pos_end = start.index + Vector2(1,next_move)
#	#Vérifier que l'on peut avancer
#	#1 - pas de boulot à faire
#	var end_cell =  pos_to_name(pos_end)
#	#2 - Personne sur la case destination
#	if 	has_node(end_cell) and get_node(end_cell).content != null :
#		return false	
##	start.remove_child(loco)
##	start.remove_from_group("Loco")
##	start.content = null
#	if has_node(pos_to_name(pos_end)):
#		player.set_loco_position(pos_end)
#	if not(has_node(pos_to_name(pos_end))) or get_node(pos_to_name(pos_end)).type == "STATION":
#		emit_signal("loco_exited",player_id)
##		loco.hide()
#		player.pop_next_move()
#		return true
#	else:
#		var end = get_node(pos_to_name(pos_end))
##		end.add_content(loco)
#		player.pop_next_move()
#		return true
