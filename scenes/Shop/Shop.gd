extends VBoxContainer

var _dumb_counter: int = 0
onready var player_id = get_tree().get_network_unique_id() 
#var player_id

signal player_ready_in_shop(player_state)

#func _init():
#	if GameState.get_players().size() == 0 :
#		GameState.add_player("1")
#		player_id = 1
#	else:
#		player_id =  get_tree().get_network_unique_id() 

func _ready():
	var _connect = self.connect("player_ready_in_shop",GameState.get_node("Network"),"_on_player_ready_in_shop")
	

#func _init():
#	GameState.add_player("1")
#	#Used for unit test.
#	if GameState.get_players().size == 0:
		

func _on_Simone_pressed():
	var selected_path = $HSplitContainer/PathShopPanel/PathShop.get_path_selected()
	if selected_path != null :
		var player = GameState.get_player(player_id)
		player.set_path(selected_path.path_preview)
		emit_signal("player_ready_in_shop",player.player_state_to_json())
#		GameState.players[1].set_path([0,0,0])
#		var _changed = get_tree().change_scene("res://scenes/Quest/Quest.tscn")
	else:
		$SimoneButton.dumb_counter += 1
