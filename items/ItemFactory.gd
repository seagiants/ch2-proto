extends Object

static func get_item(caracs):
	var item = load("res://items/Item.tscn").instance()
	item.init(caracs)
	return item	

