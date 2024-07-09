include("src/core.jl")
include("src/MazeGeneration.jl")
include("src/visualize.jl")
include("src/solver.jl")

function maze(height::Int,width::Int)
    @assert width*height > 1 "a single field is a boring maze..."
    #generate matrix with nodes whose position are the respective coordinates
    maze = [Node((i,j)) for i=1:height, j=1:width]
    start::Node = rand(maze)
    visited::Vector{Tuple{Int,Int}} = [start.pos]
    generate_matrix(start, visited, maze, (width,height))
    #choose random start for maze
    start = rand(maze)
    #choose random target for maze and re-choose if target is start
    target::Node = rand(maze)
    while start == target
        target = rand(maze)
    end
    Labyrinth = Maze(maze,start,target, nothing, nothing)
    solve(Labyrinth);
    MazeViz(Labyrinth);
    Labyrinth = Labyrinth;
end