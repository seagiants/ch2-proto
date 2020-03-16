extends Node

const Ability_Description = {
	"commerce":{
		"description" : "+1 coin",
		"icon" : "PLAIN"
	},
	"recolte_bois":{
		"description" : "+1 puissance",
		"icon" : "FOREST"
	}
}

func filter_abilities(tileType, abilities):
	var nabilities = []
	for ability in abilities:
		var f = funcref(self,"%s_cond" % ability)
		if f.call_func(tileType):
			nabilities.append(ability)
	return nabilities

func resolve_ability(ability,state):
	var f = funcref(self,"%s_resolver" % ability)
	return f.call_func(state)
	
func get_ability_description(ability_name):
	return Ability_Description[ability_name]

func commerce_cond(tile_type):
	return tile_type == "PLAIN"
	
func commerce_resolver(state):
	print("Resolve commerce")
	state.add_coin(1)
	return state

func recolte_bois_cond(tile_type):
	return tile_type == "FOREST"
	
func recolte_bois_resolver(state):
	print("Resolve recolte_bois")
	state.add_power(1)
	return state
