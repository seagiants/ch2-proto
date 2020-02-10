extends HBoxContainer

signal hero_item_selected_shop(hi)

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero_item = preload("res://HeroItem.tscn")
	for _i in range(3):
		var hi = hero_item.instance()
		add_hero_item(hi)

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("hero_item_selected_shop",hi)

func add_hero_item(hi):
	add_child(hi)
	hi.connect("gui_input",self,"on_gui_input",[hi])

func remove_hero_item(hi):
	hi.disconnect("gui_input",self,"on_gui_input")
	remove_child(hi)
