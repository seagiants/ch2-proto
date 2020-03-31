extends Control
const Tile = preload("res://scenes/Quest/tiles/tile.gd")
const Loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn")

signal loco_exited(player_index)
signal map_clicked(tile_index)

#Used to retrieve picked path in pathShop
var index = 0
#To refactor : à consolider avec les conditions des abilités côté héros, là c'est quick&dirty
var abilities = {
	"MOUNTAIN" : ["working"]
}


func init():	
#	var length = 4
	init_map(GameState.get_current_map())
	for player in GameState.get_players() :
		init_loco(player.get_name())
		init_rails(player.get_name())

func preview():
	var npreview = GameState.get_current_map(true) 
	init_map(npreview)

func init_loco(player_id):
	var loco = Loco.instance()
#	var pos = Vector2(GameState.get_turn(),1 + GameState.separation*player_index)
	var pos = GameState.get_player(player_id).get_loco_position()
	loco.init(player_id)
#	GameState.players[player_index].set_loco_position(pos)
	get_node(pos_to_name(pos)).add_content(loco)

func init_map(map : Array):
	var _connect = self.connect("loco_exited",GameState,"on_loco_exited")
#	print("Mapsize : %s" % map.size())	
	for i in map.size():
		for j in map[i].size():
			var template = map[i][j]
			var pos = Vector2(i,j)
			var cell = Tile.new(template,pos)
			add_child(cell)
			cell.set_name(pos_to_name(template.index))
			cell.connect("tile_clicked",self,"on_tile_clicked")
	

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
		get_node(pos_to_name(cell)).add_rail()
		
func pos_to_name(pos: Vector2):
	var text = str(pos[0])+"x"+str(pos[1]) 
	return text

func on_tile_clicked(_ctile):	
	emit_signal("map_clicked",index)

func get_loco_tile(player_index):
	var start = GameState.get_player(player_index).get_loco_position()
	var out = get_node(pos_to_name(start)) 
	return out

#To refactor : A consolider avec le get_abilities côté playerState
func get_abilities(cell_type):
	if cell_type in abilities.keys():
		return abilities[cell_type]
	else:
		return []
	
#To refactor, dans le GameState ou playerState. Ici devrait y avoir que la partie bouger un icone de Loco.
func advance_loco(player_id):
	var start = get_loco_tile(player_id)
	#Pas de position pour la loco = loco exited (à améliorer)
	if start == null :
		return false
	var loco = start.content
	var next_move = GameState.get_player(player_id).get_next_move()
	#Ajout d'un move par défaut pour les tests principalement.
	if next_move == null :
		next_move = 0
#		print("Arrivé à la station")
	#Récupération de la position après move
	var pos_end = start.index + Vector2(1,next_move)
	#Vérifie que l'on peut avancer
	var work_to_do = GameState.get_player(player_id).get_working_turn()
	if work_to_do == 0 :			
		start.remove_child(loco)
		start.remove_from_group("Loco")
		start.content = null
		if has_node(pos_to_name(pos_end)):
			GameState.get_player(player_id).set_loco_position(pos_end)
		if not(has_node(pos_to_name(pos_end))) or get_node(pos_to_name(pos_end)).type == "STATION":
			emit_signal("loco_exited",player_id)
			loco.hide()
			return true
		else:
			var end = get_node(pos_to_name(pos_end))
			end.add_content(loco)
			return true
	#Doing work to do...
	else :
		GameState.get_player(player_id).set_working_turn(work_to_do - 1)
		return false
