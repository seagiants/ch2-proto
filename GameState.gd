extends Node
const HeroFactory = preload("res://heroes/HeroFactory.gd")
const PlayerState = preload("res://playerState.gd")
const Loco = preload("res://scenes/Quest/tiles/tilesSprite/LocoTiles.tscn")
const players = []

func _ready():
	var player
	for _i in [1,2]:
		var hero = HeroFactory.new().get_hero("MERCHANT")
		player = PlayerState.new()
		player.set_loco(Loco.instance())
		players.append(player)
		player.add_hero(hero)
