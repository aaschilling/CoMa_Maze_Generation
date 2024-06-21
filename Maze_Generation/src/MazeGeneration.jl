include("core.jl")
struct Maze
    nodes::Matrix{Node}
    #visual::Union{MazeViz, Nothing}
    #path::Union{Vector{Node}, Nothing}
end

function maze(width::Int, height::Int)
    nodes = []
    for n in 1:height
        for m in 1:width
            push!(nodes, Node(width, height, (n,m)))
        end
    end
    return nodes
end

height = 3
width = 2
x = maze(width, height)
print(x)
#Hallo
#du