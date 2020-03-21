extends Node

const types = { 
	"PLAIN" : {
	"color":Color(1,1,1,1),
	"id": "0x0"
	},
	"MOUNTAIN" : {
	"color":Color(0,0,0,1),
	"id": "0x0"
	},
	"FOREST" : {
	"color":Color(0,1,0,1),
	"id": "0x0"
	}
}

func get_tilePool():
	return types.keys()

#var tilePool = ["PLAIN","MOUNTAIN","FOREST"]
