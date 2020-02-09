extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero_shop = preload("res://HeroShop.tscn")
	for i in range(3):
		var hs = hero_shop.instance()
		var x = 200 * i
		var y = 100
		var pos = Vector2(x, y)
		hs.global_position = pos
		add_child(hs)
