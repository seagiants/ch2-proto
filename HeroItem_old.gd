extends TextureRect
#Used to check if an item can be bought
var equippable = funcref(self,"inShop")
signal item_equipped(ei)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func inShop(_cost):
	return false

#Fired dropping a node is offered
func can_drop_data(_pos, data):
	return equippable.call_func(data.cost)

#Fired when dropping a node on it
func drop_data(_pos, data):
	var shop = self.find_parent("Shop")
	var equipShop = shop.find_node("EquipShop")
	var soldContainer = equipShop.get_node(data.parentName)
	emit_signal("item_equipped",data.cost)
	soldContainer.free()
