extends Button

signal fucking_signal

func _pressed():
	emit_signal("fucking_signal")

