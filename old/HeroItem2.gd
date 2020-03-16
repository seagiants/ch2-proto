extends PanelContainer

export var hp = 1 setget set_hp,get_hp
export var pw = 1 setget set_pw,get_pw
export var heroName = "John Doe" setget set_name,get_name
#Used to check if an item can be bought
var equippable = funcref(self,"inShop")
signal item_equipped(ei)
signal hero_selected(hi) 

func _ready():
	var click = get_node("Clickablezone")
	click.connect("gui_input",self,"on_gui_input",[click])
	click.connect("item_dropped",self,"on_item_dropped")

func init(ht):	
	self.hp = ht["hp"]
	self.pw = ht["pw"]
	self.heroName = ht["name"]

func on_item_dropped(cost):
	emit_signal("item_equipped",cost)

func on_gui_input(event,hi):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("hero_selected",hi)
		
func set_hp(nhp):
	hp=nhp
#	print("setting hp to "+ str(nhp))
	$VSplitContainer/VBoxContainer/VSplitContainer/hpLabel.set_stat(nhp)

func get_hp():
	return hp

func set_pw(npw):
	pw=npw
#	print("setting pw to "+ str(npw))
	$VSplitContainer/VBoxContainer/VSplitContainer/powerLabel.set_stat(npw)

func get_pw():
	return pw
	
func set_name(nname):
	heroName=nname
#	print("setting name to "+ str(nname))
	$VSplitContainer/VBoxContainer/HeroName.set_text(nname)

func get_name():
	return heroName

func inShop(_cost):
#	print("in shop")
	return false


