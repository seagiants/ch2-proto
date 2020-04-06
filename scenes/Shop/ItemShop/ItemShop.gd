extends Control

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const ItemFactory = preload("res://items/ItemFactory.gd")
const LvlUpButton = preload("res://scenes/Shop/ShopLvlUp.tscn")

signal item_lvl_up(player_id)
var player_id
var shop

func _ready():
	player_id = get_tree().get_network_unique_id()
	shop = DragShop.instance()
	add_child(shop)
	var player = GameState.get_player(player_id)
	var nb = player.get_items_level()
	#Add lvl up button
	var lvl = LvlUpButton.instance()
	lvl.init("path",nb)
	lvl.connect("lvl_up",self,"on_lvl_up")
#	lvl._lvl = player.get_heroes_level()
	shop.add_child(lvl)
	var _conn= self.connect("item_lvl_up",player,"on_item_lvl_up")
	#Add item init
	var items_caracs = GameState.draw_new_items(nb)
	for item_caracs in items_caracs:
		add_item(item_caracs)
	

func add_item(item_caracs : Dictionary):
	var item = ItemFactory.get_item(item_caracs)
	shop.add_drag(item)

func on_lvl_up(_type_name):
	add_item(GameState.draw_new_items(1)[0])
	emit_signal("item_lvl_up",player_id)

