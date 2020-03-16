extends VBoxContainer


func _ready():
	pass
#	$PlayerBoardPanel/PlayerBoard.init()


func _on_Simone_pressed():
	get_tree().change_scene("res://scenes/Quest/Map.tscn")
