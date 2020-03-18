extends Node

const Item_Lib = {
	"voltage" : {
		"class" : "Item",
		"type" : "voltage",
		"description" : "Mettez un lion dans votre moteur"
	}
}

func get_pool():
	return Item_Lib.keys()

static func get_item_template(it):
	return Item_Lib[it]
