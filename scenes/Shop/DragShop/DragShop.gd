extends HBoxContainer
const DragContainer = preload("res://scenes/Shop/DragShop/DragContainer.gd")

func add_drag(new_drag: Control):
		var container = DragContainer.new()
		new_drag.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		container.add_child(new_drag)
		container.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		container.set_v_size_flags(Control.SIZE_EXPAND_FILL)
		container.rect_min_size =Vector2(96,128)
		add_child(container)
		move_child(container,0)
