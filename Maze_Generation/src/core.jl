struct Node
    pos::Tuple{Int, Int}
    neighbours::Vector{Tuple{Int, Int}}
    leftchild::Union{Node, Nothing}
    rightchild::Union{Node, Nothing}

    function Node(width::Int, height::Int, position::Tuple{Int, Int})
        pos = position
        neighbours = []
        
        leftchild = nothing
        rightchild = nothing
        return new(pos, neighbours, leftchild, rightchild)
    end
end

