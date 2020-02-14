extends Node2D

var SERVER_IP = "127.0.0.1"
var SERVER_PORT = 9000
var MAX_PLAYERS = 2

func _ready():
	$LobbyInfoBox.text += "This is the place\n"
	
	$ServerButton.connect("create_server", self, "_server_creation")
	$ClientButton.connect("client_connection", self, "_client_connection")
	
	get_tree().connect("network_peer_connected", self, "_player_connected")	
	get_tree().connect("connection_failed", self, "_connected_fail")
	
func _player_connected():
	$LobbyInfoBox.text += "a player has connected to the game"
	print("a player has connected to the game")

func _connected_fail():
	$LobbyInfoBox.text += "Connection failed\n"
	
func _server_creation():
	$LobbyInfoBox.text += "Server creation event\n"
	var peer = NetworkedMultiplayerENet.new()
	var status = peer.create_server(SERVER_PORT, MAX_PLAYERS)
	if status == OK:
		get_tree().set_network_peer(peer)
		$LobbyInfoBox.text += "Server listening to %d\n" % SERVER_PORT
	else:
		$LobbyInfoBox.text += "Error creating server (Error %d)\n" % status 

func _client_connection():
	$LobbyInfoBox.text += "Connection as a client"
	var peer = NetworkedMultiplayerENet.new()
	var status = peer.create_client(SERVER_IP, SERVER_PORT)
	if status == OK:
		$LobbyInfoBox.text += "Connection successfull!"
		get_tree().set_network_peer(peer)
	else:
		$LobbyInfoBox.text += "Error connecting as a client (Error %d)" % status
	

