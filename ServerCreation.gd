extends Button

var SERVER_PORT = 9000
var MAX_PLAYERS = 1

func _pressed():
	print("Creating server")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	print("Server listening to ", SERVER_PORT)
	var addrs = IP.get_local_interfaces()
	print(addrs)
	print(get_tree().is_network_server())
