extends Node2D

var SERVER_PORT = 9000
var MAX_PLAYERS = 1

func _ready():
	print("Creating server")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	print("Server listening to ", SERVER_PORT)
