extends Object

static func get_hero(caracs):
	var hero = load("res://heroes/Hero.tscn").instance()
	hero.init(caracs)
	return hero	

