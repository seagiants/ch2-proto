extends Control

signal equip_item_selected_shop(hi)

#const Equip_Lib = {
#	"Sword" : {
#		"cost" : "1",
#		"path" : "res://assets/sword.png"
#	},
#	"Axe" : {
#		"cost": "2",
#		"path" : "res://assets/axe2.png"
#	}
#}

const EquipItem = preload("res://EquipItem.tscn")
const EquipItemContainer = preload("res://EquipItemContainer.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var lib = load_equip_lib()
	for i in lib:
		var ei = EquipItem.instance()
		ei.init(lib[i].cost,lib[i].path)
		add_equip_item(ei)

func add_equip_item(ei):
	var container = EquipItemContainer.instance()
	container.add_child(ei)
	add_child(container)
	ei.parentName = (container.get_name())
	ei.connect("gui_input",self,"on_gui_input",[ei])

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("equip_item_selected_shop",hi)

func remove_equip_item(ei):
	ei.disconnect("gui_input",self,"on_gui_input")
	ei.get_parent().free()
	#remove_child(ei)
	
func load_equip_lib():
	var save_game = File.new()
	save_game.open("res://lib/new.lib", File.READ)
	#save_game.open("res://lib/new.lib", File.WRITE)
	#save_game.store_line(to_json(Equip_Lib))
	var node_data = parse_json(save_game.get_line())
	save_game.close()
	return node_data
