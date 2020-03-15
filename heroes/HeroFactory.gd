extends Object

func get_hero(hero_name):
	var hero = load("res://heroes/%s.tscn" % hero_name).instance()
	hero.init()
	return hero	
