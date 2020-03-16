extends Control

signal item_dropped(ei)
#Fired dropping a node is offered
func can_drop_data(_pos, data):
	return get_parent().equippable.call_func(data.cost)

#Fired when dropping a node on it
func drop_data(_pos, data):
	var shop = self.find_parent("Shop")
	var equipShop = shop.find_node("EquipShop")
	var soldContainer = equipShop.get_node(data.parentName)
	emit_signal("item_dropped",data)
	soldContainer.free()
