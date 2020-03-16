extends HBoxContainer

var player

signal hero_item_selected_playerboard(hi)
signal equip_on_hero_item(eicost)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = GameState.players[0]
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

#Utiliser pour changer les conditions d'acceptation d'un drag&drop pour un HeroItem
func check_coin(cost):
	var check = int(cost) <= player.get_coin()
#	print(check) 
	return check

#On met à jour coin et on passe l'info pour que le PlayerBoardPanel mette à jour le coinLabel
func on_item_equipped(eicost):
	emit_signal("equip_on_hero_item",eicost)
