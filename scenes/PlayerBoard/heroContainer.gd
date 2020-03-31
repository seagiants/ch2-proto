extends PanelContainer

signal hero_dropped(hero)
signal hero_updated(hero)

func _ready():
	pass

#Fired dropping a node is offered
func can_drop_data(_pos, data):
	if data.caracs.type != "Hero":
		return false
	if get_child_count() == 0:
		return true
	if get_child(0).accept(data) == true:
		return true
	else:
		return false

#Fired when dropping a node on it
func drop_data(_pos, data):
	#Remove picked one from shop
	data.get_parent().remove_child(data)
	#If empty slot adding new one
	if get_child_count() == 0 :
		add_child(data)
		emit_signal("hero_dropped",data.caracs)
	#If occupied slot, upgrading old one
	else:
		get_child(0).upgrade_hero(data.caracs)
		#Emit signal with updated caracs to update gameSate
		emit_signal("hero_updated",get_child(0).caracs)
