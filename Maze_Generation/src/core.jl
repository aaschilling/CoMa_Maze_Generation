mutable struct Node
    pos::Tuple{Int, Int}
    conected::Union{Vector{Tuple{Int, Int}}, Nothing}
    #leftchild::Union{Node, Nothing}
    #rightchild::Union{Node, Nothing}

    function Node(pos::Tuple{Int, Int})
        leftchild = nothing
        rightchild = nothing
        return new(pos, [])#, leftchild, rightchild)
    end
end

#function to generate a list of neighbouring nodes that haven't been visited yet
function neighbours(node::Node,visited::Vector{Tuple{Int,Int}},size::Tuple{Int,Int})::Vector{Node}
    #println("illegal neighbours (visited): $visited")
    width = size[1]
    height = size[2]
    neighbours::Vector{Node} = []
    node.pos[1]-1 >= 1 && !((node.pos[1]-1,node.pos[2]) in visited) ? push!(neighbours, Node((node.pos[1]-1,node.pos[2]))) : nothing
    node.pos[1]+1 <= width && !((node.pos[1]+1,node.pos[2]) in visited) ? push!(neighbours, Node((node.pos[1]+1,node.pos[2]))) : nothing
    node.pos[2]-1 >= 1 && !((node.pos[1],node.pos[2]-1) in visited) ? push!(neighbours, Node((node.pos[1],node.pos[2]-1))) : nothing
    node.pos[2]+1 <= height && !((node.pos[1],node.pos[2]+1) in visited) ? push!(neighbours, Node((node.pos[1],node.pos[2]+1))) : nothing
    return neighbours
end