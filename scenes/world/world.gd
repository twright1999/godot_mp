extends Node2D

const PLAYER = preload("res://scenes/player/player.tscn")

func _ready() -> void:
	# Only server needs to spawn players to avoid duplication
	if multiplayer.is_server():
		# Connects another player joining to creating a player
		MultiplayerManager.connect("player_joined", add_player)
		
		# Adds character for server to control
		add_player(multiplayer.get_unique_id())

func add_player(peer_id) -> void:
	# Creates new player and assigns their name to peer id
	var new_player = PLAYER.instantiate()
	new_player.name = str(peer_id)
	$MultiplayerElements.add_child(new_player)
