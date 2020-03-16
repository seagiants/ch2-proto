extends Control

export(int) var cost

export(String) var iconPath

export(String) var parentName

func _init():
	pass

func init(ncost=0,path="res://assets/swordWood.png"):
	cost = ncost
	iconPath = path
	#Needed to forward the show action on drop to the target node
	#set_drag_forwarding(self)
	$Icon.texture = load(path)
	$Cost.text = str(ncost)

#Fired when dragging a node.
func get_drag_data(_pos):
	#Create a copy of the dragged item to show the drag
	var ei = self.duplicate()
	ei.init(self.cost,self.iconPath)
	ei.get_node("Cost").hide()
	set_drag_preview(ei)
	#Hard to handle the show back when dropped nowhere
	#self.hide()
	return self


