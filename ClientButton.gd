extends Button

var SERVER_IP = "0.0.0.0"
var SERVER_PORT = 9000

func _pressed():
	print("Connection as a client to: ", SERVER_IP, ":", SERVER_PORT)
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	print(get_tree().is_network_server())
