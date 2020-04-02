extends Button

func _pressed():
#	var _temp = get_tree().change_scene("res://scenes/Shop/Shop.tscn")
	rpc("test")
	
	
remote func test():
		GameState.init()
