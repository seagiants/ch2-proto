extends PanelContainer

var caracs

func init(ncaracs : Dictionary):
	caracs = ncaracs.duplicate()	
	$HBoxContainer/ItemDescription.set_text(caracs.description)
	$HBoxContainer/ItemSprite.texture = load("res://items/ItemsTexture/%s.png" % caracs.type)
