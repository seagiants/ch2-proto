extends VBoxContainer

# Just connect the nodes.
func _ready():
	if $HeroShopPanel/HeroShop.connect("hero_item_selected_shop",self,"on_hero_item_selected_shop") != OK:
		print("pb lors de la connexion hero_item_selected_shop au shop")
	if $HeroShopPanel/HeroShop.connect("max_hero_picked",self,"on_max_hero_picked") != OK:
		print("pb lors de la connexion hero_item_selected_playerboard au shop")	
	if $PlayerBoardPanel/PlayerBoard.connect("hero_item_selected_playerboard",self,"on_hero_item_selected_playerboard") != OK:
		print("pb lors de la connexion hero_item_selected_playerboard au shop")
	if $EquipShopPanel/EquipShop.connect("equip_item_selected_shop",self,"on_equip_item_selected_shop") != OK:
		print("pb lors de la connexion equip_item_selected_shop au shop")
	$PlayerBoardPanel/InfoPanel/coinLabel.set_new_coin(get_coin())


func on_hero_item_selected_shop(hi):
	$HeroShopPanel/HeroShop.remove_hero_item(hi)
	$PlayerBoardPanel/PlayerBoard.add_hero_item(hi)
	$Log.text=$Log.text + "\nAchat d'un héros"

func on_equip_item_selected_shop(_hi):
	$Log.text=$Log.text + "\nAchat d'un equipement"

func on_hero_item_selected_playerboard(_hi):
	$Log.text=$Log.text + "\nOui oui, tu as bien acheté ce héros."

func on_max_hero_picked():
	$Log.text=$Log.text + "\nAssez de héros pour l'instant."

func get_coin():
	return $PlayerBoardPanel/PlayerBoard.get_coin()
