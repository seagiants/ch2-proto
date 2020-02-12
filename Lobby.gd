extends Node2D

var SERVER_PORT = 9000
var MAX_PLAYERS = 2

func _ready():
	$LobbyInfoBox.text += "This is the place\n"
	
	
	$ServerButton.connect("fucking_signal", self, "_server_creation")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	
func _player_connected():
	print("a player has connected to the game")
	
func _server_creation():
	$LobbyInfoBox.text += "Server creation event\n"
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	$LobbyInfoBox.text += "Server listening to %d" % SERVER_PORT
	

