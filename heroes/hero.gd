extends Node2D
const HeroLib = preload("res://heroes/HeroLib.gd")
export var hero_name : String
var abilities

func init():
	print(hero_name)
	abilities = HeroLib.get_hero_template(hero_name).abilities.duplicate()
	
func _ready():
#	hero_name = hname
	$PanelContainer/Label.set_text(hero_name)
	
