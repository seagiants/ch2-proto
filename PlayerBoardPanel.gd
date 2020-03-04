extends VSplitContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	if $PlayerBoard.connect("equip_on_hero_item",self,"on_equip_on_hero_item") != OK :
		print("Impossible de se connecter au PlayerBoard")
	$InfoPanel/coinLabel.set_stat(playerState.get_coin())
	
func on_equip_on_hero_item(ei):
	playerState.set_coin(playerState.get_coin()-int(ei.cost))
	$InfoPanel/coinLabel.set_stat(playerState.get_coin())
