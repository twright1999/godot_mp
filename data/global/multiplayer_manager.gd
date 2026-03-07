extends Node

signal player_joined(peer_id)

func create_server(port : int) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	print("SERVER: server created on port ", port)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(peer_id: int) -> void:
			print("SERVER: ", peer_id, " connected to server")
			player_joined.emit(peer_id)
	)
	
	multiplayer.peer_disconnected.connect(
		func(peer_id: int) -> void:
			print("SERVER: ", peer_id, " disconnected from server")
	)

func join_server(ip, port) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	print("CLIENT: connected as ", multiplayer.get_unique_id())
