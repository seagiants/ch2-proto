extends VSplitContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerBoard.connect("equip_on_hero_item",self,"on_equip_on_hero_item")
	print($PlayerBoard.coin)
	$InfoPanel/coinLabel.set_new_coin($PlayerBoard.coin)
	
func on_equip_on_hero_item(_ei):
	$InfoPanel/coinLabel.set_new_coin($PlayerBoard.coin)
