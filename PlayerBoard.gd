extends HBoxContainer

signal hero_item_selected_playerboard(hi)

var coin = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_hero_item(hi):
	add_child(hi)
	hi.connect("gui_input",self,"on_gui_input",[hi])

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("hero_item_selected_playerboard",hi)

func get_coin():
	return coin
