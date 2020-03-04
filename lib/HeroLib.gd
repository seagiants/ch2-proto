extends Node

const Hero_Lib = {
	"Warrior" : {
		"name" : "Bob",
		"hp" : 3,
		"pw" : 1
	},
	"Rogue" : {
		"name" : "Ted",
		"hp" : 2,
		"pw" : 1
	},
	"Fishman" : {
		"name" : "Nat",
		"hp" : 1,
		"pw" : 1
	}
}

func get_hero_template(ht):
#	print (Hero_Lib[ht])
	return Hero_Lib[ht]

#const EquipItemContainer = preload("res://EquipItemContainer.tscn")
## Called when the node enters the scene tree for the first time.
#func _ready():
#	var lib = load_equip_lib()
#	for i in lib:
#		var ei = EquipItem.instance()
#		ei.init(lib[i].cost,lib[i].path)
#		add_equip_item(ei)
#
#func load_equip_lib():
#	var save_game = File.new()
#	save_game.open("res://lib/EquipLib.tres", File.READ)
##	save_game.open("res://lib/EquipLib.tres", File.WRITE)
##	save_game.store_line(to_json(Equip_Lib))
#	var node_data = parse_json(save_game.get_line())
#	save_game.close()
#	return node_data

