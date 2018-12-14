#The overlay node uses _draw() to draw lines to mark out rows and columns on top of the TileMap

extends Node2D

onready var map = get_node("..")
var gridColor = Color(0.5, 0.5, 0.5, 1)
var showGrid = true

var gridPath = []

var font = DynamicFont.new()

func _ready():
	var data = DynamicFontData.new()
	data.font_path = "res://arial.ttf"
	font.font_data = data
	font.size = 12

func _process(delta):
	update()

func draw_grid():
	
	var map_rows = map.map_rows
	var map_cols = map.map_cols
	var map_size = map.map_size
	var tileSize = map.tileSize
	
	#show current paths
	if gridPath.size() > 0 : draw_path_tiles()
	
	#Draw some gridlines
	for r in range(1, map_rows):
		var startLine = Vector2(0, r * tileSize.y) + position
		var endLine = Vector2(map_size.x, r * tileSize.y) + position
		draw_line(startLine, endLine, gridColor, 1.0, false)
		
		
	for c in range(1, map_cols):
		var startLine = Vector2(c * tileSize.x, 0) + position
		var endLine = Vector2(c * tileSize.x, map_size.y) + position
		draw_line(startLine, endLine, gridColor, 1.0, false)
	
	for r in range(map_rows):
		for c in range(map_cols):			
			var text = "("+str(c)+","+str(r)+")"
			draw_string(font, Vector2(c*tileSize.x+5, r*tileSize.y+15), text, gridColor)
	

func draw_path_tiles():	
	for pos in gridPath :
		draw_rect(Rect2(pos * map.tileSize, map.tileSize), Color(0, 1, 0, 0.7))
		
func show_path(path):
	gridPath = path

	
func _draw():
	if showGrid : draw_grid()

		
