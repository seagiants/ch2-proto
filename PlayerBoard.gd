extends HBoxContainer

signal hero_item_selected_playerboard(hi)
signal equip_on_hero_item(eicost)

export var coin = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_hero_item(hi):
	add_child(hi)
	hi.equippable = funcref(self,"check_coin")
	hi.connect("gui_input",self,"on_gui_input",[hi])
	hi.connect("item_equipped",self,"on_item_equipped")

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("hero_item_selected_playerboard",hi)

func get_coin():
	return coin

#Utiliser pour changer les conditions d'acceptation d'un drag&drop pour un HeroItem
func check_coin(cost):
	return int(cost) <= coin

#On met à jour coin et on passe l'info pour que le PlayerBoardPanel mette à jour le coinLabel
func on_item_equipped(eicost):
	coin -= int(eicost)
	emit_signal("equip_on_hero_item",eicost)
