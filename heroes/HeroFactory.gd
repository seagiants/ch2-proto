extends Object

func get_hero(hero_name,caracs = null):
	var hero = load("res://heroes/%s.tscn" % hero_name).instance()
	hero.init(caracs)
	return hero	

