extends Node
#const HeroLib = preload("res://heroes/HeroLib.gd")
const PlayerState = preload("res://playerState.gd")
#const Loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn")
const players = []

func _init():
	var player
	for _i in [1,2]:
		player = PlayerState.new()
		players.append(player)

func draw_new_items(nb = 3):
	randomize()
	var draws = []
	var pools = ItemLib.get_pool()	
	for _i in range(nb):
		pools.shuffle()
		var draw = ItemLib.get_item_template(pools[0])
		draws.append(draw)	
	return draws

func draw_new_heroes(nb = 3):
	randomize()
	var draws = []
	var pools = HeroLib.get_pool()	
	for _i in range(nb):
		pools.shuffle()
		var draw = HeroLib.get_hero_template(pools[0])
		draws.append(draw)	
	return draws
