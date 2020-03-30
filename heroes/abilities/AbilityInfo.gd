extends PanelContainer

#onready var nameLabel = get_node("MarginContainer/VSplitContainer/NameLabel")
#onready var descriptionLabel = get_node("MarginContainer/VSplitContainer/HBoxContainer/DescriptionLabel")
#onready var icon = get_node("MarginContainer/VSplitContainer/HBoxContainer/ColorRect")

func _ready():
	pass

func init(ability_name):
	var nameLabel = get_node("MarginContainer/VSplitContainer/NameLabel")
	var descriptionLabel = get_node("MarginContainer/VSplitContainer/HBoxContainer/DescriptionLabel")
	var icon = get_node("MarginContainer/VSplitContainer/HBoxContainer/ColorRect")
	var ability_description = AbilityLib.Ability_Description[ability_name]
	nameLabel.text = ability_name
	descriptionLabel.text = ability_description.description
	icon.color = TilesType.types[ability_description.icon].color
#	set_z_index()
