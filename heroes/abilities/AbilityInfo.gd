extends CanvasLayer

#onready var nameLabel = get_node("MarginContainer/VSplitContainer/NameLabel")
#onready var descriptionLabel = get_node("MarginContainer/VSplitContainer/HBoxContainer/DescriptionLabel")
#onready var icon = get_node("MarginContainer/VSplitContainer/HBoxContainer/ColorRect")

func _ready():
	pass

func init(ability_name):
	var nameLabel = get_node("AbilityInfo/MarginContainer/VSplitContainer/NameLabel")
	var descriptionLabel = get_node("AbilityInfo/MarginContainer/VSplitContainer/HBoxContainer/DescriptionLabel")
	var icon = get_node("AbilityInfo/MarginContainer/VSplitContainer/HBoxContainer/ColorRect")
	var ability_description = AbilityLib.Ability_Description[ability_name]
	nameLabel.text = ability_description.name
	descriptionLabel.text = ability_description.description
	icon.color = TilesType.types[ability_description.icon].color
#	set_z_index()

func show():
	get_child(0).set_position(get_viewport().get_mouse_position() + Vector2(16,16))
	get_child(0).show()

func hide():
	get_child(0).hide()
