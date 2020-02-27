extends Button

signal send_chat_message

func _pressed():
	emit_signal("send_chat_message")
