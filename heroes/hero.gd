extends Container

const AbilityLabel = preload("res://heroes/abilities/AbilityLabel.tscn")

var caracs



const RACELIB = {
	"Human":{
		"color":Color(0.97,0.69,0.76,1)
	},
	"Elf":{
		"color":Color(0.88,0.97,0.69,1)
	},
	"Dwarf":{
		"color":Color(1,0.53,0.44,1)
	}
}

func _ready(pre_init = false):
	#Use just for test-unit purpose
	if pre_init == true :
		var Lib = preload("HeroLib.gd").new() 
		init(Lib.get_hero_template("Forestier"))
	
func init(ncaracs : Dictionary):
	caracs = ncaracs.duplicate()
	$VBoxContainer/Label.set_text(caracs.name+"\n"+caracs.race)
	set_race_color()
	for ability in caracs.abilities:
		add_ability(ability)

#Adding display for an ability
func add_ability(ability_name):
		var info_desc = AbilityLabel.instance()
		$VBoxContainer.add_child(info_desc)	
		info_desc.init(ability_name)

func get_abilities():
	return caracs.abilities

func get_race_color():
	return RACELIB[caracs.race].color

func set_race_color():
	var style = StyleBoxFlat.new()
	style.set_bg_color(get_race_color())
	style.set_corner_radius_all(4)
	set("custom_styles/panel",style)
#	print("Setting to :"+str(get_race_color()))
#	print(get("custom_styles/panel"))
#	get("custom_styles/panel").set_bg_color(get_race_color())

func accept(ncaras):
	return caracs.race == ncaras.caracs.race

func upgrade_hero(ncaracs):
	for ability in ncaracs.abilities:
		if not(ability in caracs.abilities):
			#Update the local state, adding new ability
			caracs.abilities.append(ability)
			#Update the hero display
			add_ability(ability)
