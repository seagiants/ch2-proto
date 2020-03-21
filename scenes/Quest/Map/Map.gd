extends Node2D
const Tile = preload("res://scenes/Quest/tiles/tile.gd")
const Loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn")

signal loco_exited(player_index)

func _ready():	
#	var length = 4
	init_map(GameState.get_current_map())
	for i in [0,1]:
		init_loco(i)
		init_rails(i)

func init_loco(player_index = 0):
	var loco = Loco.instance()
#	var pos = Vector2(GameState.get_turn(),1 + GameState.separation*player_index)
	var pos = GameState.players[player_index].get_loco_position()
	loco.init(player_index)
#	GameState.players[player_index].set_loco_position(pos)
	get_node(pos_to_name(pos)).add_content(loco)

func init_map(map : Array):
	self.connect("loco_exited",GameState,"on_loco_exited")
#	print("Mapsize : %s" % map.size())	
	for i in map.size():
		for j in map[i].size():
			var pos = Vector2(i,j)
			var cell = Tile.new(map[i][j],pos)
			add_child(cell)
			cell.set_name(pos_to_name(pos))
			cell.connect("tiles_clicked",self,"on_tiles_clicked")
	

func init_rails(player_index):
	var path = GameState.players[player_index].get_path()
	var cells = []
	var next = GameState.players[player_index].get_loco_position() 
	cells.append(next)
	for move in path:
		next = next + Vector2(1,move)
		cells.append(next)
	for cell in cells:
		get_node(pos_to_name(cell)).add_rail()
		
func pos_to_name(pos: Vector2):
	var text = str(pos[0])+"x"+str(pos[1]) 
	return text

func on_tiles_clicked(_ctile):	
	for i in [0,1]:
		var start = get_loco_tile(i)
		var player = GameState.players[i]
		var cell_type = start.type
		for ability in player.get_abilities(cell_type):
			AbilityLib.resolve_ability(ability,player)
		advance_loco(i)

func get_loco_tile(index):
	var start = GameState.players[index].get_loco_position()
	var out = get_node(pos_to_name(start)) 
	return out

func advance_loco(i):
#	print("turn : %s" % GameState.get_turn())
#	print("Loco : %s" % i)
	var start = get_loco_tile(i)
	#Pas de position pour la loco = loco exited (à améliorer)
	if start == null :
		return
	var loco = start.content
#	print("Loco of player%s" % loco.player_index)
	var pos_end = start.index + Vector2(1,0)
	start.remove_child(loco)
	start.remove_from_group("Loco")
	start.content = null
	if not(has_node(pos_to_name(pos_end))) or get_node(pos_to_name(pos_end)).type == "STATION":
		emit_signal("loco_exited",i)
		loco.hide()
#		var _changed = get_tree().change_scene("res://scenes/Shop/Shop.tscn")
		return
	else:
		var end = get_node(pos_to_name(pos_end))
		GameState.players[i].set_loco_position(pos_end)
		end.add_content(loco)
