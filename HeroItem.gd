extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Fired dropping a node is offered
func can_drop_data(_pos, data):
	return true

#Fired when dropping a node on it
func drop_data(_pos, data):
	var shop = self.find_parent("Shop")
	var equipShop = shop.find_node("EquipShop")
	var soldContainer = equipShop.get_node(data.parentName)
	soldContainer.free()
