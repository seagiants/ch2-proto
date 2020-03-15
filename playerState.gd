extends Node

var _coin = 15 setget set_coin,get_coin

var _power = 1 setget set_power,get_power

var _loco setget set_loco,get_loco

var _heroPool = [] setget set_heroPool,get_heroPool

func set_heroPool(hpool):
	_heroPool = hpool

func get_heroPool():
	return _heroPool

func add_hero(hero):
	_heroPool.append(hero)

func get_abilities(tileType = null):
	var abilityLib = preload("res://heroes/abilities/AbilityLib.gd").new()
	var abilities = []
	for hero in _heroPool:
		for ability in abilityLib.filter_abilities(tileType,hero.abilities):
				abilities.append(ability)
	return abilities
			
func set_loco(loco):
	_loco = loco

func get_loco():
	return _loco

func get_power():
	return _power

func set_power(npower: int):
	_power = npower

func get_coin():
	return _coin

func set_coin(ncoin: int):
	_coin = ncoin
	
func add_coin(ncoin: int):
	_coin += ncoin
	print(_coin)
