extends Node

const Hero_Lib = {
	"Marchand" : {
		"class": "Hero",
		"type" : "Marchand",
		"name" : "Bob",
		"abilities" : ["commerce"]
	},
	"Forestier" : {
		"class": "Hero",
		"type" : "Forestier",
		"name" : "Ted",
		"abilities" : ["recolte_bois"]
	}
}

func get_pool():
	return Hero_Lib.keys()

static func get_hero_template(ht):
	return Hero_Lib[ht]
