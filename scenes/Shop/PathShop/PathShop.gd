extends Control

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const LvlUpButton = preload("res://scenes/Shop/ShopLvlUp.tscn")
const Map = preload("res://scenes/Quest/Map/Map.tscn")
var shop
var path_selected = null
var paths
var player_id 
var lvl_up_button

signal path_lvl_up(player_id)

func _ready():
	player_id = get_tree().get_network_unique_id()
	shop = DragShop.instance()
	add_child(shop)
	var player = GameState.get_player(player_id)
	var nb = player.get_paths_level()
	#Add lvl up button
	var lvl = LvlUpButton.instance()
	lvl.init("path",player.get_heroes_level())
	lvl.connect("lvl_up",self,"on_lvl_up")
	lvl._lvl = player.get_heroes_level()
	shop.add_child(lvl)
	lvl_up_button = lvl
	var _conn= self.connect("path_lvl_up",player,"on_path_lvl_up")
	#Add first paths
	paths = GameState.draw_new_paths(player_id,nb)
#	var paths = GameState.draw_new_paths()
	var index = 0
	for path in  paths:
#		add_path(path)
		add_path(path,index,player_id)
		index  += 1

#D'abord prendre une miniature de la map et ajouter les rails dessus
func add_path(path: Array, index, nplayer_id):
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
	new_map.init_rails(nplayer_id,path)

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

func on_lvl_up(_type_name):
	add_path(GameState.draw_new_paths(player_id,1)[0],0,player_id)
	emit_signal("path_lvl_up",player_id)
