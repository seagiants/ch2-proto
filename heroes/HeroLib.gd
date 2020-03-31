extends Node

onready var _lib = load_heroes_lib()

func load_heroes_lib():
	"""
	Load heroes library from the JSON file
	"""
	print("Loading heroes library.")
	var file = File.new()
	file.open("res://heroes/heroes-lib.json", file.READ)
	var json = file.get_as_text()
	var lib = JSON.parse(json).result
	print("Heroes list is :")
	for heroes_classes in lib.keys():
		print(heroes_classes)
	return(lib)
	
func get_heroes_lib():
	return _lib
	
func get_pool():
	var Hero_Lib = get_heroes_lib()
	return Hero_Lib.keys()

func get_hero_template(ht):
	var Hero_Lib = get_heroes_lib()
	return Hero_Lib[ht]
