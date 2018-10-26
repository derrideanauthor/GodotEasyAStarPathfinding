# Easy AStar path finding in GDScript
Alternative A* pathfinding class for Godot 

Godot does have AStar pathfinding but the process is tedious to set up - all points have to be manually added and connected. This class has been painstakingly rewritten to gdscript. Original author and source is at the top in **AStar_memtronic.gd**. If you have similar issues with Godot's pathfinding node, give this a try.

This script contains the following path finding modes:

- Diagonal
- DiagonalFree
- Euclidean
- EuclideanFree
- Manhattan

As of yet there is no weighting options. Please contribute if you feel this is a feature worth adding.

#Usage

  1. Prepare a 2D array representing walkable and unwalkable tiles in your game
    ` var map = [[0, 0, 0, 0]
    `            [1, 1, 1, 0]
    `            [0, 0, 0, 0]

