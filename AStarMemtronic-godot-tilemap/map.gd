#- As you will see, the Map node contains this script which does the pathfinding for us
#  Simply change the TileMap with your own and you can use this script as is

#- * If you would like to know more about how the pathfinder works read the comments below for a step by step

extends Node2D

#Used to store information about the TileMap
var tileSize = Vector2(0, 0)
var map_rows = 0
var map_cols = 0
var map_size = Vector2(0, 0)


#Virtual map - array of arrays a.k.a. a 2D array whose indexes represent the rows and columns of the map
#E.g. tile_grid[5][6] = 1 :: will indicate that col 6, row 5 is occupied
var tile_grid = []



#Preload the pathfinder class 
const AStarMemtronic = preload("res://AStar_memtronic.gd")

#Instantiate the pathfinder class 
onready var PathFinder = AStarMemtronic.new()

#Reference to the Game node
onready var gameNode = get_node("..")

func _ready():
	
	#Lets find out how many rows and columns our TileMap node has
	var mapSize = calculate_tilemap_size($TileMap)
	map_rows = mapSize.rows
	map_cols = mapSize.cols
	
	#If we know how big the tiles are, we can calculate actual dimensions of the map
	#This might be useful if you want to make it scroll
	tileSize = gameNode.tileSize
	map_size.x = map_cols * tileSize.x
	map_size.y = map_rows * tileSize.y

	#To get the pathfinder to work we need to set up a grid map
	create_tile_grid()


func create_tile_grid():
	
	#--We need to create a tile grid to feed the pathfinder. It is a 2D array to represent rows and columns; a virtual map!.--
	#  For this example we will make a tile grid from the TileMap  
	#  BUT you can easily create one without this function, E.g.:
	# 
	# tile_grid = [
	#	[0, 0, 1, 0],
	#	[0, 0, 1, 0],
	#	[0, 0, 1, 0],
	#	[0, 0, 0, 0]
	# ]
	#
	#--Here 1 represent blocked tiles and 0 open tiles. Do you see the 1x3 wall? --
	
	#Making a tile_grid from the TileMap
	
	# 1- Create empty 2d array corresponding to the amount of rows and columns on the map
	# A virtual map or tile grid. 0 represents an open tile amd 1 represents a blocked tile
	for r in range(map_rows):
		var rowArray = [] 
		for c in range(map_cols):
			rowArray.append(0)
		tile_grid.append(rowArray)
	
	# 2- Populate the tile grid with the positions of blocked tiles
	
	#To do that we will retrieve the TileMap node (first child to the map scene) to get information about the tiles
	var tileset = $TileMap.get_tileset()
	
	# - Next we run through all the tiles in the TileMap, one by one. We add all cellnames 
	#   containing "blocked" in its name to tile_grid (just like creating the wall in the custom tile_grid above). 
	#	These kinds of tiles (water/walls/rocks) will represent impassible barriers (1) in the tile_grid

	
	for r in range(map_rows):
		for c in range(map_cols):
			var cell = $TileMap.get_cell(c, r)
			var tileName = tileset.tile_get_name(cell)

			#Identify tiles by name
			if tileName.find("blocked") >= 0 : 
				tile_grid[r][c] = 1
	
	# * Alternatively use $TileMap.get_used_cells_by_id(n) to select tiles you want by ID
	#	This number (n) is automaticly set when you put together a TileMap. You can see them when youve made 
	#   a tileset file (.tres). A list of IDs will show up in the inspector panel if you doubleclick on this resource file
	#   E.g.:
#	var cells = $TileMap.get_used_cells_by_id(2) 
#	for cell in cells:
#		tile_grid[cell.y][cell.x] = 1

# this function can be run from the Game node
func make_path(startPos, endPos, method) :
	
	# - Using the find_path method we get an array containing Vector2 tile coordinates of the calculated path
	#   a sprite could follow. E.g. [Vector2(1,2), Vector2(2,2), ...] 
	#   (It uses the tile_grid 2D array allocated in the create_tile_grid() function.)
	return PathFinder.find_path(tile_grid, startPos, endPos, method)

func toggle_grid():
	$Overlay.showGrid = !$Overlay.showGrid

#This function finds all the tiles in the tilemap and figures out how many there are in each row and column
func calculate_tilemap_size(tilemap):
	# Get list of all positions where there is a tile
	var used_cells = tilemap.get_used_cells()

	# If there are none, return null result
	if used_cells.size() == 0:
		return {x=0, y=0, width=0, height=0}

	# Take first cell as reference
	var min_x = used_cells[0].x
	var min_y = used_cells[0].y
	var max_x = min_x
	var max_y = min_y

	# Find bounds
	for i in range(1, used_cells.size()):

		var pos = used_cells[i]
		if pos.x < min_x:
			min_x = pos.x
		elif pos.x > max_x:
			max_x = pos.x

		if pos.y < min_y:
			min_y = pos.y
		elif pos.y > max_y:
			max_y = pos.y

	# Return resulting bounds
	return {
		"cols" : max_x - min_x + 1,
		"rows" : max_y - min_y + 1
	}
