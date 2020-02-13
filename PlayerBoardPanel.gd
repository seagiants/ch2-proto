extends VSplitContainer

var coin = 2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerBoard.connect("equip_on_hero_item",self,"on_equip_on_hero_item")
	$PlayerBoard.coin = coin
	$InfoPanel/coinLabel.text = str(coin)
	
func on_equip_on_hero_item(_ei):
	$InfoPanel/coinLabel.set_new_coin($PlayerBoard.coin)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
