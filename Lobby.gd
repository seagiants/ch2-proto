extends Node2D

var SERVER_IP = "127.0.0.1"
var SERVER_PORT = 9000
var MAX_PLAYERS = 2

var IPS = {
	"localhost": "127.0.0.1",
	"Eric": "192.168.0.0"
}

func _ready():
	
	$IPSelect.add_item("localhost")
	$IPSelect.add_item("Eric")
	
	$LobbyInfoBox.text += "This is the place\n"
	
	$ServerButton.connect("create_server", self, "_server_creation")
	$ClientButton.connect("client_connection", self, "_client_connection")
	$SendChatMessage.connect("send_chat_message", self, "_on_send_message")
	
	get_tree().connect("network_peer_connected", self, "_player_connected")	
	get_tree().connect("connection_failed", self, "_connected_fail")
	
func _player_connected(connected_player_id):
	$LobbyInfoBox.text += "Player %s connected" % connected_player_id

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
	$LobbyInfoBox.text += "Connection as a client \n"
	var peer = NetworkedMultiplayerENet.new()
	var selected_adress_idx = $IPSelect.get_selected_items()[0]
	var ip = IPS[$IPSelect.get_item_text(selected_adress_idx)]
	$LobbyInfoBox.text += "IP is %s \n" % ip
	var status = peer.create_client(ip, SERVER_PORT)
	if status == OK:
		$LobbyInfoBox.text += "Connection successfull!\n"
		get_tree().set_network_peer(peer)
	else:
		$LobbyInfoBox.text += "Error connecting as a client (Error %d)" % status
	
func _on_send_message():
	var message = $ChatInput.text
	rpc("send_message", message)
	

remotesync func send_message(message):
	$ChatDisplay.text += "%s \n" % message
