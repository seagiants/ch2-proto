extends Container


func _ready():
	pass

func get_drag_data(_pos):
	if get_child_count() > 0 :
		var hi = get_child(0).duplicate()
		set_drag_preview(hi)
		return get_child(0)
	else:
		return null
