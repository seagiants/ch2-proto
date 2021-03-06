extends HBoxContainer

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const LvlUpButton = preload("res://scenes/Shop/ShopLvlUp.tscn")
const Map = preload("res://scenes/Quest/Map/Map.tscn")
var shop
var _path_selected_container_id = null
#var paths
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
	add_child(lvl)
	lvl_up_button = lvl
	var _conn= self.connect("path_lvl_up",player,"on_path_lvl_up")
	#Add paths
	for path in  GameState.draw_new_paths(player_id,nb):
#		add_path(path)
		add_path(path,player_id)
#		index  += 1

#D'abord prendre une miniature de la map et ajouter les rails dessus
func add_path(path: Array, nplayer_id):
	var new_map = Map.instance()
	new_map.preview()
	new_map.set_mouse_filter(Control.MOUSE_FILTER_PASS)
#	new_map.preview = true
#	var new = Control.new()
#	var new_container = Container.new()
#	new_container.rect_min_size =Vector2(96,128)
#	new_container.add_child(new_map)
#	add_child(new_container)
#	new_map.rect_min_size =Vector2(96,128)
	new_map.set_scale(Vector2(0.25,0.25))
	shop.add_drag(new_map)
	new_map.connect("map_clicked",self,"on_map_clicked")
	new_map.init_rails(nplayer_id,path)


#Buggée !!!!!!!!
func get_path_selected():
	if _path_selected_container_id != null:
		return shop.get_node(_path_selected_container_id).get_child(0)
	else:
		return null

func on_map_clicked(clicked_path_id):
	var path = get_path_selected()
	if path != null:
		get_path_selected().modulate = Color(1,1,1,1)
	if clicked_path_id != _path_selected_container_id :
		_path_selected_container_id = clicked_path_id
		get_path_selected().modulate = Color(1,1,1,0.5)
	else :
		_path_selected_container_id = null

func on_lvl_up(_type_name):
	var new_path = GameState.draw_new_paths(player_id,1)[0]
	add_path(new_path,player_id)
#	paths.append(new_path)
	
	emit_signal("path_lvl_up",player_id)
