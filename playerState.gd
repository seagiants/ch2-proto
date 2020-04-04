extends Node

var _index = 0 setget set_index,get_index
var _coin = 15 setget set_coin,get_coin
var _power = 1 setget set_power,get_power
var _working_turn = 0 setget set_working_turn, get_working_turn
var _hp = 5 setget set_hp,get_hp
var _heroPool = [] setget set_heroPool,get_heroPool
var _itemPool = [] setget set_itemPool,get_itemPool
var _loco_position setget set_loco_position, get_loco_position
var _path = [0,0,0] setget set_path, get_path
var _player_color = Color(0,0,0,1) setget set_player_color, get_player_color
var _player_name = "John Doe" setget set_player_name, get_player_name
var _heroes_level = 2 setget set_heroes_level, get_heroes_level
var _paths_level = 2 setget set_paths_level, get_paths_level
var _items_level = 0 setget set_items_level, get_items_level
#var _move_index = 0 setget set_move_index,get_move_index

#signal loco_stats_changed()
signal player_died(player_id)
signal player_stats_changed(player_id,stat_name,old_value,new_value)
signal player_moved(player_id,old,new)
#signal player_heroes_changed(player_id,level_type,old,new)
signal player_level_changed(player_id,level_type,old,nlevel)

func _init(index = 0, pos = Vector2(0,1)):
	_index = index
	_loco_position = pos
	var _con = self.connect("player_died",GameState,"on_player_died")

func player_state_to_json():
	return {
		"id":get_name(),
		"_index":_index,
		"_coin":_coin,
		"_working_turn":_working_turn,
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
	if _path.size() == 0:
		return 0
	else :
		return _path[0]
	
func pop_next_move():
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
	
func get_working_turn():
	return _working_turn

func add_working_turn(nworking_turn: int):
	 set_working_turn(_working_turn + nworking_turn)


func is_advancing():
	return get_working_turn() == 0

func do_work():
	add_working_turn(-1)

func set_working_turn(nworking_turn : int):
	_working_turn = nworking_turn
	
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
	var old = _loco_position
	_loco_position = pos
	emit_signal("player_moved",get_name(),old,pos)

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
	var old = _power
	_power = npower	
	emit_signal("player_stats_changed",get_name(),"power",old,npower)
#	emit_signal("loco_stats_changed")
	
func get_hp():
	return _hp

func set_hp(nhp: int):
	var old = _hp
	_hp = nhp
	emit_signal("player_stats_changed",get_name(),"hp",old,nhp)
#	emit_signal("loco_stats_changed")
	if _hp <= 0:
		emit_signal("player_died",get_name())

func add_power(npower: int):
	set_power(_power + npower)

func get_coin():
	return _coin

func set_coin(ncoin: int):
	var old = _coin
	_coin = ncoin
	emit_signal("player_stats_changed",get_name(),"coin",old,ncoin)
#	emit_signal("loco_stats_changed")
	
func add_coin(ncoin: int):
	set_coin(_coin + ncoin)

func get_heroes_level():
	return _heroes_level

func set_heroes_level(nlevel: int):
	var old = _heroes_level
	_heroes_level = nlevel
	emit_signal("player_level_changed",get_name(),"heroes",old,nlevel)
#	emit_signal("loco_stats_changed")

func up_heroes_level():
	self._heroes_level += 1

func on_hero_lvl_up(_player_id):
	up_heroes_level()
	
func get_items_level():
	return _items_level

func set_items_level(nlevel: int):
	var old = _items_level
	_items_level = nlevel
	emit_signal("player_level_changed",get_name(),"items",old,nlevel)
#	emit_signal("loco_stats_changed")

func up_items_level():
	self._items_level += 1

func on_item_lvl_up(_player_id):
	up_items_level()
	
func get_paths_level():
	return _paths_level

func set_paths_level(nlevel: int):
	var old = _paths_level
	_paths_level = nlevel
	emit_signal("player_level_changed",get_name(),"paths",old,nlevel)
#	emit_signal("loco_stats_changed")

func up_paths_level():
	self._paths_level += 1

func on_path_lvl_up(_player_id):
	up_paths_level()

func update_hero(ncaracs):
	var hp = get_heroPool()
	for i in hp.size():
		if hp[i].hero_id == ncaracs.hero_id:
			hp.remove(i)
			hp.insert(i,ncaracs)

func resolve_attack(attack):
	set_hp(get_hp()-attack)	
