extends Node2D

const Rails = preload("res://scenes/Quest/tiles/tilesSprite/Rail.tscn")
const Stations = preload("res://scenes/Quest/tiles/tilesSprite/StationTiles.tscn")

var colors = [Color(0,1,1,1), Color(0,0,1,1), Color(1,0,0,1),Color(1,0,1,1),Color(1,1,1,1)]

var index = Vector2(0,0)
var type
var content = null
var hei
var wid
var abPosition
signal tiles_clicked(tile)

func _init(ncell, pos = Vector2(0,0), h = 80, w = 80):
	hei = h
	wid = w
	var tile
	if ncell.type == "STATION":
		tile = Stations.instance()
	else :
		tile = ColorRect.new()
		var ncolor = TilesType.types[ncell.type].color
		tile.color = ncolor
		var label = Label.new()
		label.text = ncell.index
		tile.add_child(label)
	type = ncell.type
	abPosition = Vector2(pos.x * h, pos.y * w)
	tile.set_size(Vector2(h,w))
	tile.set_position(abPosition)
#	randomize()
#	colors.shuffle()
	
	index = pos
	add_child(tile)
	tile.connect("gui_input",self,"on_click")

func add_content(ncontent):
#	var contentSprite = load("res://scenes/Quest/tiles/tilesSprite/"+content_type+"Tiles.tscn")
#	content = contentSprite.instance()
	content = ncontent
	content.tile_position = index
	content.set_position(abPosition+Vector2(hei/2,wid/2-6))
	add_child(content)
	self.add_to_group(content.content_type)

func add_rail():
	var rail = Rails.instance()
	rail.set_position(abPosition+Vector2(hei/2,wid-5))	
	add_child(rail)

func on_click(event):	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("tiles_clicked",self)
