extends Button

signal create_server

func _pressed():
	emit_signal("create_server")

