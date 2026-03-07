extends Node

func _ready():
	# On ready, loads UI and connects button pressed signals
	var UI = load("res://scenes/world/ui.tscn").instantiate()
	UI.connect("create_server_pressed", create_lobby)
	UI.connect("join_server_pressed", join_lobby)
	add_child(UI)
	
func create_lobby(port):
	# Handles the creation of a multiplayer server
	MultiplayerManager.create_server(port)
	
	# Moves to game world
	load_lobby()

func join_lobby(ip, port):
	# Handles joining a multiplayer server
	MultiplayerManager.join_server(ip, port)
	
	# Moves to game world
	load_lobby()

func load_lobby():
	# Kills child UI
	$UI.queue_free()
	
	# Loads game world
	var game_world = load("res://scenes/world/world.tscn").instantiate()
	add_child(game_world)
