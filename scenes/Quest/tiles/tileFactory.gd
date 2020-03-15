extends Node

static func get_tiles(numb: int):
	randomize()
	var tiles = []
	var types = TilesType.tilePool.duplicate()
	for _i in range(numb):
		types.shuffle()
		tiles.append(types[0])
	return tiles
