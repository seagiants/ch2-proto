extends Node

var _index
var _coin = 15 setget set_coin,get_coin
var _power = 1 setget set_power,get_power
var _hp = 5 setget set_hp,get_hp
var _heroPool = [] setget set_heroPool,get_heroPool
var _itemPool = [] setget set_itemPool,get_itemPool
var _loco_position setget set_loco_position, get_loco_position
var _path = [0,0,0] setget set_path, get_path
#var _move_index = 0 setget set_move_index,get_move_index

signal loco_stats_changed(player_index)

func _init(index = 0, pos = Vector2(0,1)):
	_index = index
	_loco_position = pos

func get_next_move():
	return _path.pop_front()

#
#func get_move_index():
#	return _move_index
#
#func set_move_index(nindex : int):
#	_move_index = nmove_index


func get_path():
	return _path

func set_path(npath : Array):
	_path = npath

func set_heroPool(hpool):
	_heroPool = hpool

func get_heroPool():
	return _heroPool

func reinit_loco_position():
	set_loco_position(Vector2(0,get_loco_position()[1]))

func set_loco_position(pos):
	_loco_position = pos

func get_loco_position():
	return _loco_position

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
		"puissance" : get_power(),
		"hp": get_hp()
	}

func get_power():
	return _power

func set_power(npower: int):
	_power = npower
	emit_signal("loco_stats_changed",_index)
	
func get_hp():
	return _hp

func set_hp(nhp: int):
	_hp = nhp
	emit_signal("loco_stats_changed",_index)

func add_power(npower: int):
	set_power(_power + npower)

func get_coin():
	return _coin

func set_coin(ncoin: int):
	_coin = ncoin
	emit_signal("loco_stats_changed",_index)
	
func add_coin(ncoin: int):
	set_coin(_coin + ncoin)
