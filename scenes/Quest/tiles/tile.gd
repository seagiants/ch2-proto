extends Node2D

var colors = [Color(0,1,1,1), Color(0,0,1,1), Color(1,0,0,1),Color(1,0,1,1),Color(1,1,1,1)]

var index = Vector2(0,0)
var type
var content = null
var hei
var wid
var abPosition
signal tiles_clicked(tile)

func _init(ntype, pos = Vector2(0,0), h = 64, w = 64):
	hei = h
	wid = w
	var tile = ColorRect.new()
	type = ntype
	abPosition = Vector2(pos.x * h, pos.y * w)
	tile.set_size(Vector2(h,w))
	tile.set_position(abPosition)
#	randomize()
#	colors.shuffle()
	var ncolor = TilesType.types[ntype].color
	tile.color = ncolor
	index = pos
	add_child(tile)
	tile.connect("gui_input",self,"on_click")

func add_content(ncontent):
#	var contentSprite = load("res://scenes/Quest/tiles/tilesSprite/"+content_type+"Tiles.tscn")
#	content = contentSprite.instance()
	content = ncontent
	content.tile_position = index
	content.set_position(abPosition+Vector2(hei/2,wid/2))
	add_child(content)
	self.add_to_group(content.content_type)

func on_click(event):	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("tiles_clicked",self)
