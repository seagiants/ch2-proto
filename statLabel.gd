extends Label

export var statNick = "stat"

func set_stat(nstat=0):
	self.text = str(nstat)+ " " + statNick
