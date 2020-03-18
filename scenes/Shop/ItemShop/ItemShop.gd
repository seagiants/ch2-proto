extends Control

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const ItemFactory = preload("res://items/ItemFactory.gd")

var shop

func _ready():
	shop = DragShop.instance()
	add_child(shop)
	var items_caracs = GameState.draw_new_items()
	for item_caracs in items_caracs:
		add_item(item_caracs)

func add_item(item_caracs : Dictionary):
	var item = ItemFactory.get_item(item_caracs)
	shop.add_drag(item)

