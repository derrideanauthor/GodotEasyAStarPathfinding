# Easy AStar path finding in GDScript
Alternative A* pathfinding class for Godot 

Godot does have AStar pathfinding but the process is tedious to set up - all points have to be manually added and connected. This class has been painstakingly rewritten to gdscript. Original author and source is at the top in **AStar_memtronic.gd**. If you have similar issues with Godot's pathfinding node, give this a try.

This script contains the following path finding modes:

- Diagonal
- DiagonalFree
- Euclidean
- EuclideanFree
- Manhattan (Default)

As of yet there is no weighting options. Please contribute if you feel this is a feature worth adding.

Usage
------------

1. Prepare a 2D array representing walkable (1) and unwalkable/blocked (0) tiles in your game. E.g. a map with 3 rows and 4 columns would look like this:

  `var map = 
  [[0, 0, 0, 0], 
  [1, 1, 1, 0], 
  [0, 0, 0, 0]]`

  *This can be a bit impractical if you have a large map. I have uploaded a Godot example to show you a great way to set it up directly from checking certain tiles in your tilemap (assuming you are using a tilemap)*

2. Initiate the pathfinder class:

  `const AStarMemtronic = preload("res://path_to_resource/AStar_memtronic.gd")`
  
  `onready var PathFinder = AStarMemtronic.new()`

3. Use the 'find_path' class method with the following 4 parameters:

  - Array, the map (see 1)
  - Vector2, start coordinates
  - Vector2, end coordinates
  - String, path finding mode (see above, optional)
  
4. Capture the resulting path; a 1D array containing Vector2 coordinates.

   `var result = PathFinder.find_path(map, Vector2(10, 9), Vector2(6, 17), "DiagonalFree")`
