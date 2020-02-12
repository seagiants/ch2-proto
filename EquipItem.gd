extends Control

export(int) var cost

func _init(ncost=0,path="res://assets/swordWood.png"):
	pass

func init(ncost=0,path="res://assets/swordWood.png"):
	cost = ncost
	$Icon.texture = load(path)
	$Cost.text = str(ncost)

	
