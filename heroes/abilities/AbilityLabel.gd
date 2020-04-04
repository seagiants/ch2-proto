extends MarginContainer

const AbilityInfo = preload("res://heroes/abilities/AbilityInfo.tscn")

var abilityName = "banque"
var abilityInfo

func _ready():
#	init()
	pass

func init(ab_name = null):
	if ab_name != null:
		abilityName = ab_name
	$AbilityLabel.set_text(AbilityLib.Ability_Description[abilityName].name)
	abilityInfo = AbilityInfo.instance()
	abilityInfo.init(abilityName)			
	$AbilityLabel.add_child(abilityInfo)
	abilityInfo.hide()
#	abilityInfo.get_child(0).hide()

#Pas réussi à la faire marcher
#func _make_custom_tooltip(for_text):
#	abilityInfo = AbilityInfo.instance()
#	abilityInfo.init(abilityName)
#	return abilityInfo


func _on_MarginAbilityLabel_mouse_entered():
#	abilityInfo.get_child(0).set_position(get_viewport().get_mouse_position() + Vector2(16,16))
#	abilityInfo.get_child(0).show()
	abilityInfo.show()

func _on_MarginAbilityLabel_mouse_exited():
#	abilityInfo.get_child(0).hide()
	abilityInfo.hide()
