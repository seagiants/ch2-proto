extends Node2D
const tile = preload("res://scenes/Quest/tiles/tile.gd")

var loco

func _ready():
	loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn").instance()
	var length = 4
	var tilesPool = preload("res://scenes/Quest/tiles/tileFactory.gd").get_tiles(length)
	print(tilesPool)
	for i in range(length):
			print(i)
			var j = 1
			var cell = tile.new(tilesPool[i],Vector2(i,j))
			print(cell)
			add_child(cell)
			cell.set_name(str(i)+"x"+str(j))
			cell.connect("tiles_clicked",self,"on_tiles_clicked")
			if i ==0:
				cell.add_content(loco)

func pos_to_name(pos: Vector2):
	var text = str(pos[0])+"x"+str(pos[1]) 
	return text

func on_tiles_clicked(_ctile):
	var player = GameState.players[0]
	var cell_type = get_loco_tile().type
	for ability in player.get_abilities(cell_type):
		AbilityLib.resolve_ability(ability,player)
	advance_loco()

func get_loco_tile():
	var start = get_tree().get_nodes_in_group("Loco")
	if start.size() !=1 :
		print("Pb pour faire avancer la loco :"+start.length())
		return 
	start = start[0]
	return start

func advance_loco():
	var start = get_loco_tile()
	loco = start.content
	var pos_end = start.index + Vector2(1,0)
	if not(has_node(pos_to_name(pos_end))):
		var _changed = get_tree().change_scene("res://scenes/newShop/new_Shop2.tscn")
		return
	else:
		var end = get_node(pos_to_name(pos_end))
		start.remove_child(loco)
		start.remove_from_group("Loco")
		end.add_content(loco)
