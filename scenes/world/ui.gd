extends VBoxContainer

const PLAYER = preload("res://scenes/player/player.tscn")

func _on_connect_button_pressed() -> void:
	join_server($TextEntryIP.text, int($TextEntryPort.text))

func _on_create_server_button_pressed() -> void:
	create_server()

func create_server() -> void:
	var peer = ENetMultiplayerPeer.new()
	var success = peer.create_server(25565)
	print(success)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(peer_id: int) -> void:
			print(peer_id)
			add_player(peer_id)
	)
	
	multiplayer.peer_disconnected.connect(
		func(peer_id: int) -> void:
			print(peer_id, "has left")
	)
	
	add_player(multiplayer.get_unique_id())

func join_server(ip, port) -> void:
	var peer = ENetMultiplayerPeer.new()
	var success = peer.create_client(ip, port)
	print(success)
	multiplayer.multiplayer_peer = peer

func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	add_child(player)
	
