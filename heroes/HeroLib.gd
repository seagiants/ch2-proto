extends Node

const Hero_Lib = {
	"Merchant" : {
		"name" : "Bob",
		"abilities" : ["GREEDY"]
	},
	"Rogue" : {
		"name" : "Ted",
		"hp" : 2,
		"pw" : 1
	}
}

static func get_hero_template(ht):
#	print (Hero_Lib[ht])
	return Hero_Lib[ht]
