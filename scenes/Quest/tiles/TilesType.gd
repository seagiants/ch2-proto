extends Node
#
#var colors = [Color(0,1,1,1), Color(0,0,1,1), Color(1,0,0,1),Color(1,0,1,1),Color(1,1,1,1)]

#const PLAIN = {
#	"color":Color(1,1,1,1)
#}
#
#const MOUNTAIN = {
#	"color":Color(0,0,0,1)
#}
#
#const FOREST = {
#	"color":Color(0,1,1,1)
#}
const types = { "PLAIN" : {
	"color":Color(1,1,1,1)
	},
	"MOUNTAIN" : {
	"color":Color(0,0,0,1)
	},
	"FOREST" : {
	"color":Color(0,1,0,1)
	}
}

var tilePool = ["PLAIN","MOUNTAIN","FOREST"]
