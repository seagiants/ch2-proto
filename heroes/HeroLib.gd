extends Node

const Hero_Lib = {
	"Merchant" : {
		"type" : "Merchant",
		"name" : "Bob",
		"abilities" : ["GREEDY"]
	},
	"Rogue" : {
		"type" : "Rogue",
		"name" : "Ted",
		"abilities" : []
	}
}

static func get_hero_template(ht):
#	print (Hero_Lib[ht])
	return Hero_Lib[ht]
