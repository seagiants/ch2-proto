extends Container

func get_drag_data(_pos):
	if get_child_count() > 0 :
#		var current_dragged = get_child(0)
#		if current_dragged.has_method("dragged"):
#			current_dragged.dragged()
		var hi = get_child(0).duplicate()
		set_drag_preview(hi)
		return get_child(0)
	else:
		return null
