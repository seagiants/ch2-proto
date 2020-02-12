extends VBoxContainer

var coinText = " PO"

# Just connect the nodes.
func _ready():
	$HeroShopPanel/HeroShop.connect("hero_item_selected_shop",self,"on_hero_item_selected_shop")
	$PlayerBoardPanel/PlayerBoard.connect("hero_item_selected_playerboard",self,"on_hero_item_selected_playerboard")
	$EquipShopPanel/EquipShop.connect("equip_item_selected_shop",self,"on_equip_item_selected_shop")
	$PlayerBoardPanel/InfoPanel/coinLabel.text = str(5)+coinText


func on_hero_item_selected_shop(hi):
	$HeroShopPanel/HeroShop.remove_hero_item(hi)
	$PlayerBoardPanel/PlayerBoard.add_hero_item(hi)
	$Log.text=$Log.text + "\nAchat d'un héros"

func on_equip_item_selected_shop(_hi):
	$Log.text=$Log.text + "\nAchat d'un equipement"

func on_hero_item_selected_playerboard(_hi):
	$Log.text=$Log.text + "\nOui oui, tu as bien acheté ce héros."

func get_coin():
	return $PlayerBoardPanel/PlayerBoard.get_coin()
