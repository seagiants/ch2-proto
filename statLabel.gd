extends Label

export var statNick = "stat"

func set_stat(nstat=0):
	print("set "+str(nstat))
	self.text = str(nstat)+ " " + statNick
