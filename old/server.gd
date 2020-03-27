extends Node

func _ready():
	#Init de la map côté du serveur
	GameState.generate_map(64,5)
	#Init du joueur "serveur"
	GameState.add_player(get_tree().get_network_unique_id())
