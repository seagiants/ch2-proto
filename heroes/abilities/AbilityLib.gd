extends Node


const Hero_Lib = {
	"Merchant" : {
		"name" : "Bob",
		"abilities" : ["GREEDY"]
	},
	"Rogue" : {
		"name" : "Ted",
		"hp" : 2,
		"pw" : 1
	}
}

func get_ability_template(at):
	return Hero_Lib[at]

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
	
func GREEDY_cond(tile_type):
	return tile_type == "PLAIN"
	
func GREEDY_resolver(state):
	print("Resolve Greedy")
	state.add_coin(1)
	return state
