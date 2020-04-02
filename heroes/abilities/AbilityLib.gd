extends Node

# FIXME dynamic function calls using a dictionnary
# FIXME properties of functions should be valued based on conf

signal ability_resolved(player_id,ability_name)

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
		"description" : "1 attack sur tt joueurs",
		"icon" : "FOREST" 
	},
	"tunnel" : {
		"description" : "Pas affecté",
		"icon" : "MOUNTAIN" 
	},
	"greedy" : {
		"description" : "+1 coin",
		"icon" : "MOUNTAIN"
	},
	"working": {
		"description" : "Du boulot pour 1 tour...",
		"icon" : "MOUNTAIN"
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
	emit_signal("ability_resolved",player_state.get_name(),ability)
	return f.call_func(player_state)
	
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

# Bank fns
func banque_cond(tile_type):
	return tile_type == "PLAIN"

func banque_resolver(state):
	print("Resolving bank")
	state.add_power(-1)
	state.add_coin(2)
	return(state)

# Bank fns
func tunnel_cond(tile_type):
	return tile_type == "MOUNTAIN"

func tunnel_resolver(state):
	print("Resolving tunnel")
#	print(state)
	state.add_working_turn(-1)
	return(state)

# Bank fns
func greedy_cond(tile_type):
	return tile_type == "MOUNTAIN"

func greedy_resolver(state):
	print("Resolving greedy")
	state.add_coin(1)
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

# Working fns
func working_cond(tile_type):
	return tile_type == "MOUNTAIN"

func working_resolver(state):
	print("Resolve working")
	#A reprendre. Buggé.
	state.set_working_turn(state.get_working_turn()+1)
	GameState.tunnel_cell(state.get_loco_position())
	return state
	
