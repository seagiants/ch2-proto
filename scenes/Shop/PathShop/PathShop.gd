extends Control

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
#const PathFactory = preload("res://items/PathFactory.gd")
const Map = preload("res://scenes/Quest/Map/Map.tscn")
var shop
var path_selected = null
var paths

func _ready():
	var player_id = get_tree().get_network_unique_id()
	shop = DragShop.instance()
	add_child(shop)
	paths = GameState.draw_new_paths(player_id)
#	var paths = GameState.draw_new_paths()
	var index = 0
	for path in  paths:
#		add_path(path)
		add_path(path,index,player_id)
		index  += 1

#D'abord prendre une miniature de la map et ajouter les rails dessus
func add_path(path : Array, index, player_id):
#	var path = PathFactory.get_item(paths)
	var new_map = Map.instance()
	new_map.preview()
	new_map.index = index
	new_map.set_scale(Vector2(0.25,0.25))
	new_map.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
#	new_map.preview = true
#	var new = Control.new()
	shop.add_drag(new_map)
	new_map.connect("map_clicked",self,"on_map_clicked")
	new_map.init_rails(player_id,path)

func get_path_selected():
	if path_selected != null :
		return paths[path_selected]
	else :
		return null
		
func on_map_clicked(map_index):
	if path_selected != null:
		shop.get_child(path_selected).modulate = Color(1,1,1,1)
	if map_index != path_selected :
		path_selected = map_index
		shop.get_child(map_index).modulate = Color(1,1,1,0.5)
	else :
		path_selected = null
