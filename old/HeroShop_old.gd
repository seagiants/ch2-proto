extends HBoxContainer
const HeroFactory = preload("res://heroes/HeroFactory.gd")
const HeroContainer = preload("res://scenes/newShop/HeroShop/heroItemContainer.gd")

func _ready():
	var heroes = GameState.draw_new_heroes()
	for hero_t in heroes:
		var hero = HeroFactory.get_hero(hero_t)
		var container = HeroContainer.new()
		hero.set_mouse_filter(Control.MOUSE_FILTER_PASS)
		container.add_child(hero)
		container.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		container.set_v_size_flags(Control.SIZE_EXPAND_FILL)
		add_child(container)
