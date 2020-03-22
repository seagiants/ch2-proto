extends VBoxContainer

func _on_Simone_pressed():
	var selected_path = $VSplitContainer/PathShop.get_path_selected()
	if selected_path != null :
		GameState.players[0].set_path(selected_path)
		GameState.players[1].set_path([0,0,0])
		var _changed = get_tree().change_scene("res://scenes/Quest/Quest.tscn")
	else : 
		print("Faut choisir un path !")
