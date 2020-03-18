extends PanelContainer

signal hero_dropped(hero)

func _ready():
	pass

#Fired dropping a node is offered
func can_drop_data(_pos, data):
	return data.caracs.class == "Hero" and get_child_count() == 0

#Fired when dropping a node on it
func drop_data(_pos, data):
	data.get_parent().remove_child(data)
	add_child(data)
	emit_signal("hero_dropped",data.caracs)
