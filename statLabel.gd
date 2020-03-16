extends Label

export var statNick : String

func _init(nick = "stat"):
	statNick = nick

func init(nick,stat):
	statNick = nick
	set_stat(stat)

func set_stat(nstat=0):
	self.text = statNick+ " : " + str(nstat)
