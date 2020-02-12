extends Control

signal equip_item_selected_shop(hi)

const Equip_Lib = {
	"Sword" : {
		"cost" : "1",
		"path" : "res://assets/sword.png"
	},
	"Axe" : {
		"cost": "2",
		"path" : "res://assets/axe2.png"
	}
}

var EquipItem = preload("res://EquipItem.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in ["Sword","Axe"]:
		var ei = EquipItem.instance()
		ei.init(Equip_Lib[i].cost,Equip_Lib[i].path)
		add_equip_item(ei)

func add_equip_item(ei):
	add_child(ei)
	ei.connect("gui_input",self,"on_gui_input",[ei])

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("equip_item_selected_shop",hi)

func remove_equip_item(ei):
	ei.disconnect("gui_input",self,"on_gui_input")
	remove_child(ei)
