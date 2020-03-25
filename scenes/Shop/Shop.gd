extends VBoxContainer

var _dumb_counter: int = 0

func _on_Simone_pressed():
	var selected_path = $VSplitContainer/PathShop.get_path_selected()
	if selected_path != null :
		GameState.players[0].set_path(selected_path)
		GameState.players[1].set_path([0,0,0])
		var _changed = get_tree().change_scene("res://scenes/Quest/Quest.tscn")
	else : 
		_dumb_counter += 1
		if _dumb_counter < 5 : 
			$Button.set_text("En voiture Simone ! (ouais enfin quand on saura où on va...)")
			print("Faut choisir un path !")
		else :
			$Button.set_text("T'es con ou quoi ?! Choisis un putain de chemin d'abord !!!")
