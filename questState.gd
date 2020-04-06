extends Node

#Used to handle the player state in a quest
#Pop when a quest is initiated, cleaned when the quest finishes

var _defence = 1 setget set_defence, get_defence

func set_defence(def: int):
	_defence = def

func get_defence():
	return _defence
