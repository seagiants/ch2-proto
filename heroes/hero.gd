extends Container
#const HeroLib = preload("res://heroes/HeroLib.gd")

const AbilityInfo = preload("res://heroes/abilities/AbilityInfo.tscn")

var hero_caracs

func init(caracs : Dictionary):
#	print(hero_name)
#	if caracs == null :
#		hero_caracs = HeroLib.get_hero_template(hero_name).duplicate()
#	else :	
	hero_caracs = caracs.duplicate()
	$VBoxContainer/Label.set_text(hero_caracs.type+"\n"+hero_caracs.name)
	for ability in hero_caracs.abilities:
		var info_desc = AbilityInfo.instance()
		$VBoxContainer.add_child(info_desc)	
		info_desc.init(ability)
#func _ready():
##	hero_name = hname
#	$VBoxContainer/Label.set_text(hero_name+"\n"+HeroLib.get_hero_template(hero_name).name)
#	init()
	
func get_abilities():
	return hero_caracs.abilities
