extends Node

# FIXME dynamic function calls using a dictionnary
# FIXME properties of functions should be valued based on conf

const Ability_Description = {
	"commerce":{
		"description" : "+1 coin",
		"icon" : "PLAIN"
	},
	"recolte_bois":{
		"description" : "+1 puissance",
		"icon" : "FOREST"
	},
	"banque" : {
		"description" : "+2 coin ; -1 puissance",
		"icon" : "PLAIN" #FIXME change to BANK, add the icon
	},
	"rangedAttack" : {
		"description" : "1 attack sur joueur 1",
		"icon" : "FOREST" #FIXME change to BANK, add the icon
	}
}

func filter_abilities(tileType, abilities):
	var nabilities = []
	for ability in abilities:
		var f = funcref(self,"%s_cond" % ability)
		if f.call_func(tileType):
			nabilities.append(ability)
	return nabilities

func resolve_ability(ability,player_state):
	var f = funcref(self,"%s_resolver" % ability)
	return f.call_func(player_state)
	
func get_ability_description(ability_name):
	return Ability_Description[ability_name]

func commerce_cond(tile_type):
	return tile_type == "PLAIN"
	
func commerce_resolver(state,_ncaracs):
	print("Resolve commerce")
	state.add_coin(1)
	return state

func recolte_bois_cond(tile_type):
	return tile_type == "FOREST"
	
func recolte_bois_resolver(state):
	print("Resolve recolte_bois")
	state.add_power(1)
	return state

# Bank fns
func banque_cond(tile_type):
	return tile_type == "PLAIN"

func banque_resolver(state):
	print("Resolving bank")
	state.add_power(-1)
	state.add_coin(2)
	return(state)

# Range_Attack fns
func rangedAttack_cond(tile_type):
	return tile_type == "FOREST"

func rangedAttack_resolver(state):
	print("Resolve rangedAttack")
	for player in GameState.get_players():
		if player.get_name() != state.get_name():
			player.resolve_attack(1)
	return state
