extends Node

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const HeroFactory = preload("res://heroes/HeroFactory.gd")
const LvlUp = preload("res://scenes/shop/ShopLvlUp.tscn")
onready var player_id = get_tree().get_network_unique_id() 
var shop

signal hero_lvl_up(player_id)

func _ready():
	shop = DragShop.instance()
	add_child(shop)
	var player = GameState.get_player(player_id) 
	var heroes_caracs = GameState.draw_new_heroes(GameState.get_player(player_id).get_heroes_level())
	for hero_caracs in heroes_caracs:
		add_hero(hero_caracs)
	var lvl = LvlUp.instance()
	lvl.init("hero",player.get_heroes_level())
	lvl.connect("lvl_up",self,"on_lvl_up")
	shop.add_child(lvl)
	var _conn= self.connect("hero_lvl_up",GameState.get_player(player_id),"on_hero_lvl_up")

func add_hero(hero_caracs : Dictionary):
	var hero = HeroFactory.get_hero(hero_caracs)
	shop.add_drag(hero)

func on_lvl_up(_type_name):
	emit_signal("hero_lvl_up",player_id)
