extends Node

var _coin = 15 setget set_coin,get_coin
var _power = 1 setget set_power,get_power
var _heroPool = [] setget set_heroPool,get_heroPool
var _itemPool = [] setget set_itemPool,get_itemPool

signal loco_stats_changed(player_index)

func set_heroPool(hpool):
	_heroPool = hpool

func get_heroPool():
	return _heroPool

func add_hero(hero):
	_heroPool.append(hero)

func set_itemPool(ipool):
	_itemPool = ipool

func get_itemPool():
	return _itemPool

func add_item(item):
	_itemPool.append(item)

func get_abilities(tileType = null):
	var abilityLib = preload("res://heroes/abilities/AbilityLib.gd").new()
	var abilities = []
	for hero in _heroPool:
		for ability in abilityLib.filter_abilities(tileType,hero.abilities):
			abilities.append(ability)
	return abilities
			
func get_loco_stats():
	return {
		"coin" : get_coin(),
		"puissance" : get_power()
	}

func get_power():
	return _power

func set_power(npower: int):
	_power = npower
	emit_signal("loco_stats_changed",0)

func add_power(npower: int):
	set_power(_power + npower)

func get_coin():
	return _coin

func set_coin(ncoin: int):
	_coin = ncoin
	emit_signal("loco_stats_changed",0)
	
func add_coin(ncoin: int):
	set_coin(_coin + ncoin)
