extends PanelContainer

var hero_box
var stat_box

func _ready():
	hero_box = get_node("HBoxContainer/PanelContainer3/HeroBox")		
#	stat_box = get_node("HSplitContainer/HBoxContainer/VBoxContainer/HBoxContainer2/PanelContainer/LocoStats")
	var pool = GameState.players[0].get_heroPool()
#	var cont
	for index in range(hero_box.get_child_count()):
		var cont = hero_box.get_child(index)
		cont.connect("hero_dropped",self,"on_hero_dropped")
	var factory = load("res://heroes/HeroFactory.gd").new()
	for i in range(pool.size()):
		var caracs = pool[i].duplicate()
		var hero = factory.get_hero(caracs)
		add_hero(hero,i)
	
func add_hero(hero,index):
	hero_box.get_child(index).add_child(hero)

func on_hero_dropped(hero):
	GameState.players[0].add_hero(hero)
