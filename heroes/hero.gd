extends Container

const AbilityInfo = preload("res://heroes/abilities/AbilityInfo.tscn")

var caracs

func init(ncaracs : Dictionary):
	caracs = ncaracs.duplicate()
	$VBoxContainer/Label.set_text(caracs.type+"\n"+caracs.name)
	for ability in caracs.abilities:
		var info_desc = AbilityInfo.instance()
		$VBoxContainer.add_child(info_desc)	
		info_desc.init(ability)
	
func get_abilities():
	return caracs.abilities
