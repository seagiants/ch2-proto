extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_new_coin(ncoin):
	self.text = str(ncoin)+ " GP"
