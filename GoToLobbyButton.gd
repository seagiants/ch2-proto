extends Button

func _pressed():
	if get_tree().change_scene("res://Lobby.tscn") != OK:
		print("Impossible de charger la scène de Lobby")
