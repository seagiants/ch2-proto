extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	set_new_coin()

func set_new_coin(ncoin=0):
	self.text = str(ncoin)+ " GP"
