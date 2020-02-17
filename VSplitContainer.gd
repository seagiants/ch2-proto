extends VSplitContainer

func _ready():
	var n = get_node("PanelContainerRoot")
	n.connect("hero_selected",self,"on_selected",[n])

func on_selected(event,hi):
		get_node("Label").set_text("selected")
