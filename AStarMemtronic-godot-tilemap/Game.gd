#--Example of how to use AStarMemtronic pathfinder script --#

#- This special bit of code makes use of a TileMap to provide the pathfinder script with a 2D Array
#- Learn more about how to generally use the pathfinder in map.gd
#- <3 PartTimePoet
 
extends Node

#Find the tilesize from the TileMap (the child to the "Map" node in this case.)
#If you dont know how to use a TileMap yet check out the Godot tutorial first
#If you are just interested in using the pathfinder, read through, it is explained well too <3
var tileSize = Vector2(64, 64)

func _ready():
	
	#We use the get_path function in the "Map" node (map.tscn, map.gd)
	#It returns an array containing Vector2 tile coordinates for each step in the path :. (column, row)
	var startPos = Vector2(0,4)
	var endPos = Vector2(5, 6)
	var path = $Map.get_path(startPos, endPos, "DiagonalFree")
	
	#- * Try using your own start and end positions to see pathfinder solve it
	#- * Invalid start or end positions (according to the tilemap) returns [] 
	
	#lets get a visual representation of the path
	$Map/Overlay.show_path(path)
	$Map/Overlay.showGrid = true
	
	print("Path to follow: "+str(path))