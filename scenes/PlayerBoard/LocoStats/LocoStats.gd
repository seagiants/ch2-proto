extends PanelContainer

const StatLabel = preload("res://statLabel.tscn")
onready var player_id = get_tree().get_network_unique_id() 
var stat_box

func _ready():
	stat_box = get_node("HSplitContainer/LocoStats"	)
	GameState.get_player(player_id).connect("player_stats_changed",self,"on_player_stats_changed")
	if(player_id != 1):
		$HSplitContainer/TextureRect.set_modulate(Color(0,0,1,1))
	init()

func init():
	for i in range(stat_box.get_child_count()):
		stat_box.get_child(i).queue_free()
	var nstats = GameState.get_player(player_id).get_loco_stats() 
	for stat in nstats.keys():
		var label = StatLabel.instance()
		label.init(stat,nstats[stat])
		stat_box.add_child(label)

#func on_loco_stats_changed():
#	for i in range(stat_box.get_child_count()):
#		stat_box.get_child(i).queue_free()
#	var nstats = GameState.get_player(player_id).get_loco_stats() 
#	for stat in nstats.keys():
#		var label = StatLabel.instance()
#		label.init(stat,nstats[stat])
#		stat_box.add_child(label)

func on_player_stats_changed(_player_id,_stat_name,_old_value,_new_value):
	init()
			
