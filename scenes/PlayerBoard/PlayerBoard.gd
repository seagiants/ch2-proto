extends PanelContainer

var hero_box
var item_box
var stat_box
onready var player_id = get_tree().get_network_unique_id()

func _ready():
	hero_box = get_node("HBoxContainer/HeroBox")		
	item_box = get_node("HBoxContainer/ItemBox")
	var hero_pool = GameState.get_player(player_id).get_heroPool()
	var item_pool = GameState.get_player(player_id).get_itemPool()
	for index in range(hero_box.get_child_count()):
		var cont = hero_box.get_child(index)
		cont.connect("hero_dropped",self,"on_hero_dropped")
	for index in range(item_box.get_child_count()):
		var cont = item_box.get_child(index)
		cont.connect("item_dropped",self,"on_item_dropped")

	var factory = load("res://heroes/HeroFactory.gd").new()
	for i in range(hero_pool.size()):
		var caracs = hero_pool[i].duplicate()
		var hero = factory.get_hero(caracs)
		add_hero(hero,i)

	var factoryI = load("res://items/ItemFactory.gd").new()
	for i in range(item_pool.size()):
		var caracs = item_pool[i].duplicate()
		var item = factoryI.get_item(caracs)
		add_item(item,i)
	
func add_hero(hero,index):
	hero_box.get_child(index).add_child(hero)

func add_item(item,index):
	item_box.get_child(index).add_child(item)

func on_hero_dropped(hero):
	GameState.get_player(player_id).add_hero(hero)

func on_item_dropped(item):
	GameState.get_player(player_id).add_item(item)
