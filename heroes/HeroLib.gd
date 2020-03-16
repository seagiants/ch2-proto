extends Node

const Hero_Lib = {
	"Marchand" : {
		"type" : "Marchand",
		"name" : "Bob",
		"abilities" : ["commerce"]
	},
	"Forestier" : {
		"type" : "Forestier",
		"name" : "Ted",
		"abilities" : ["recolte_bois"]
	}
}

func get_pool():
	return Hero_Lib.keys()

static func get_hero_template(ht):
#	print (Hero_Lib[ht])
	return Hero_Lib[ht]
