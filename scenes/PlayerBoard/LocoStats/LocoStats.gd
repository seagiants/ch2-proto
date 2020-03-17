extends PanelContainer

const StatLabel = preload("res://statLabel.tscn")

var stat_box

func _ready():
	stat_box = get_node("HSplitContainer/LocoStats"	)
	GameState.players[0].connect("loco_stats_changed",self,"on_loco_stats_changed")
	on_loco_stats_changed(0)

func on_loco_stats_changed(player_index):
	for i in range(stat_box.get_child_count()):
		stat_box.get_child(i).queue_free()
	var nstats = GameState.players[player_index].get_loco_stats() 
	print(nstats)
	for stat in nstats.keys():
		var label = StatLabel.instance()
		label.init(stat,nstats[stat])
		stat_box.add_child(label)
			
