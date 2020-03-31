extends Node

var _index = 0 setget set_index,get_index
var _coin = 15 setget set_coin,get_coin
var _power = 1 setget set_power,get_power
var _hp = 5 setget set_hp,get_hp
var _heroPool = [] setget set_heroPool,get_heroPool
var _itemPool = [] setget set_itemPool,get_itemPool
var _loco_position setget set_loco_position, get_loco_position
var _path = [0,0,0] setget set_path, get_path
var _player_color = Color(0,0,0,1) setget set_player_color, get_player_color
var _player_name = "John Doe" setget set_player_name, get_player_name
#var _move_index = 0 setget set_move_index,get_move_index

signal loco_stats_changed()

func _init(index = 0, pos = Vector2(0,1)):
	_index = index
	_loco_position = pos

func player_state_to_json():
	return {
		"id":get_name(),
		"_index":_index,
		"_coin":_coin,
		"_power":_power,
		"_hp":_hp,
		"_heroPool":_heroPool,
		"_itemPool":_itemPool,
		"_loco_position":_loco_position,
		"_path":_path		
#		"_path":_path,
#		"_player_color": _player_color
	}

func update_from_json(json_player_state):
	for key in json_player_state.keys():
		if key != "id":
			var setter = funcref(self,"set"+key)
			setter.call_func(json_player_state[key])	

func get_starting_position():
	return Vector2(0,1+2*_index)
	
func get_next_move():
	return _path.pop_front()

func get_avalaible_moves(pos = null):	
#	print("Avalaible moves :")
	var starting_y = 1+2*get_index()	
	var y_pos
	if pos == null:
		y_pos = get_loco_position()[1]
	else:
		y_pos = pos[1]
#	print("        y-pos:"+str(y_pos))
	if y_pos ==	starting_y:
#			print("        0")
			return [-1,0,1]
	if y_pos == starting_y+1:
#			print("        1")
			return [-1,0]
	if y_pos == starting_y-1:
#			print("        -1")
			return [1,0]
		
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
	
func get_player_color():
	return _player_color

func set_player_color(ncolor : Color):
	_player_color = ncolor

func get_player_name():
	return _player_name

func set_player_name(nname : String):
	_player_name = nname
	
func get_index():
	return _index

func set_index(nindex : int):
	_index = nindex

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
	emit_signal("loco_stats_changed")
	
func get_hp():
	return _hp

func set_hp(nhp: int):
	_hp = nhp
	emit_signal("loco_stats_changed")

func add_power(npower: int):
	set_power(_power + npower)

func get_coin():
	return _coin

func set_coin(ncoin: int):
	_coin = ncoin
	emit_signal("loco_stats_changed")
	
func add_coin(ncoin: int):
	set_coin(_coin + ncoin)

func update_hero(ncaracs):
	var hp = get_heroPool()
	for i in hp.size():
		if hp[i].hero_id == ncaracs.hero_id:
			hp.remove(i)
			hp.insert(i,ncaracs)
