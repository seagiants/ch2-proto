extends MarginContainer

const AbilityInfo = preload("res://heroes/abilities/AbilityInfo.tscn")

var abilityName = "banque"
var abilityInfo

func _ready():
	init()

func init(ab_name = null):
	if ab_name != null:
		abilityName = ab_name
	$AbilityLabel.set_text(abilityName)
	abilityInfo = AbilityInfo.instance()
	abilityInfo.init(abilityName)			
	$AbilityLabel.add_child(abilityInfo)
	abilityInfo.set_position(Vector2(32,20))
	abilityInfo.hide()

func _make_custom_tooltip(for_text):
	abilityInfo = AbilityInfo.instance()
	abilityInfo.init(abilityName)
	return abilityInfo


func _on_MarginAbilityLabel_mouse_entered():
	abilityInfo.show()


func _on_MarginAbilityLabel_mouse_exited():
	abilityInfo.hide()
#	pass
