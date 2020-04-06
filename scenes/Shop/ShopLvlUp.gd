extends TextureRect

var _lvl = 2
var _cost = 0
var _stat = "hero"

const pattern = "to level {lvl}"
signal lvl_up(type_name)

func init(stat,lvl,cost = 2):
#	var string = pattern.format({"lvl": _lvl})
	_stat = stat
	_lvl = lvl
	_cost = cost
#	$VBoxContainer/Label.set_text(str(string))

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("lvl_up",_stat)
#		hide()
