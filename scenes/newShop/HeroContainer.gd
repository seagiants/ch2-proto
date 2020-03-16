extends PanelContainer

func _ready():
	pass

func get_drag_data(_pos):
	var hi = get_child(0).duplicate()
	set_drag_preview(hi)
	return get_child(0)
