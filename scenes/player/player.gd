extends CharacterBody2D

@export var speed = 400

func _enter_tree() -> void:
	# Peer id must match player name in order to control
	set_multiplayer_authority(int(str(name)))
	global_position = get_viewport_rect().size / 2

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(_delta):
	# Only take player input from peer with authority
	if !is_multiplayer_authority():
		return
	get_input()
	move_and_slide()
