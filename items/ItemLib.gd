extends Node

const Item_Lib = {
	"voltage" : {
		"type" : "Item",
		"name" : "voltage",
		"description" : "Mettez un lion dans votre moteur",
		"abilities": []
	},
	"blindage" : {
		"type" : "Item",
		"name" : "blindage",
		"description" : "+1 Defense",
		"abilities": [{"ability_name":"armored","atts":{"armor":2}}]
	}
}

func get_pool():
	return Item_Lib.keys()

static func get_item_template(it):
	return Item_Lib[it]
