extends PanelContainer

signal item_dropped(item)

#Fired dropping a node is offered
func can_drop_data(_pos, data):
	return data.caracs.type == "Item" and get_child_count() == 0

#Fired when dropping a node on it
func drop_data(_pos, data):
	data.get_parent().remove_child(data)
	add_child(data)
	emit_signal("item_dropped",data.caracs)
