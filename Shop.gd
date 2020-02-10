extends VBoxContainer

# Just connect the nodes.
func _ready():
	$HeroShopPanel/HeroShop.connect("hero_item_selected_shop",self,"on_hero_item_selected_shop")
	$PlayerBoardPanel/PlayerBoard.connect("hero_item_selected_playerboard",self,"on_hero_item_selected_playerboard")

func on_hero_item_selected_shop(hi):
	$HeroShopPanel/HeroShop.remove_hero_item(hi)
	$PlayerBoardPanel/PlayerBoard.add_hero_item(hi)
	$Log.text=$Log.text + "\nAchat d'un héros"

func on_hero_item_selected_playerboard(_hi):
	$Log.text=$Log.text + "\nOui oui, tu as bien acheté ce héros."
