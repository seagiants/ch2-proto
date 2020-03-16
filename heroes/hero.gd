extends Container
const HeroLib = preload("res://heroes/HeroLib.gd")
export var hero_name : String
var hero_caracs

func init(caracs = null):
	print(hero_name)
	if caracs == null :
		hero_caracs = HeroLib.get_hero_template(hero_name).duplicate()
	else :
		hero_caracs = caracs.duplicate()
		
func _ready():
#	hero_name = hname
	$VBoxContainer/Label.set_text(hero_name+"\n"+HeroLib.get_hero_template(hero_name).name)
	init()
	
func get_abilities():
	return hero_caracs.abilities
