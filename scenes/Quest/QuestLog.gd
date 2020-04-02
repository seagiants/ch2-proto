extends Node2D

var _logs = []
func _ready():
	var  _con
	for player in GameState.get_players():
		_con = player.connect("player_stats_changed",self,"on_player_stats_changed")
		_con = player.connect("player_moved",self,"on_player_moved")
	_con = AbilityLib.connect("ability_resolved",self,"on_ability_resolved")

func on_ability_resolved(player_id,ability_name):
	var change = {}
	change.player_id = player_id
	change.stat = ability_name
	change.description = str(player_id) + " : " + "Resolve "+ str(ability_name) + "\n"
	_logs.append(change)
	$RichTextLabel.text += change.description 

func on_player_stats_changed(player_id,stat_name,old,new):
	var change = {}
	change.player_id = player_id
	change.stat = stat_name
	change.old = old
	change.new = new
	change.description = str(player_id) + " : " + str(stat_name) + "= "+ str(old) + " -> "+ str(new) + "\n"
	_logs.append(change)
	$RichTextLabel.text += change.description 

func on_player_moved(player_id,old,new):
	var change = {}
	change.player_id = player_id
	change.stat = "move"
	change.old = old
	change.new = new
	change.description = str(player_id) + " : " + " move = "+ str(old) + " -> "+ str(new) + "\n"
	_logs.append(change)
	$RichTextLabel.text += change.description 
