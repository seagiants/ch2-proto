extends Button

signal client_connection

func _pressed():
	emit_signal("client_connection")
