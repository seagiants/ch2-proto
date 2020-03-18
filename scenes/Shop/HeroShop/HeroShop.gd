extends Node

const DragShop = preload("res://scenes/Shop/DragShop/DragShop.tscn")
const HeroFactory = preload("res://heroes/HeroFactory.gd")

var shop

func _ready():
	shop = DragShop.instance()
	add_child(shop)
	var heroes_caracs = GameState.draw_new_heroes()
	for hero_caracs in heroes_caracs:
		add_hero(hero_caracs)

func add_hero(hero_caracs : Dictionary):
	var hero = HeroFactory.get_hero(hero_caracs)
	shop.add_drag(hero)

