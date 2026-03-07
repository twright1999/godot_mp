extends VBoxContainer

# Signals for when buttons are pressed
signal create_server_pressed(port: int)
signal join_server_pressed(ip : String, port : int)

func _on_connect_button_pressed() -> void:
	join_server_pressed.emit($TextEntryIP.text, int($TextEntryPort.text))

func _on_create_server_button_pressed() -> void:
	create_server_pressed.emit(int($TextEntryPort.text))
