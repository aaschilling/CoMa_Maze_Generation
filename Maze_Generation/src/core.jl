struct Node
    pos::Tuple{Int, Int}
    neighbours::Vector{Tuple{Int, Int}}
    leftchild::Union{Node, Nothing}
    rightchild::Union{Node, Nothing}

    function Node(width::Int, height::Int, position::Tuple{Int, Int})
        pos = position
        neighbours = []
        pos[1]-1 >= 1 ? append!(nachbar, [(pos[1]-1,pos[2])]) : nothing
        pos[1]+1 <= n ? append!(nachbar, [(pos[1]+1,pos[2])]) : nothing
        pos[2]-1 >= 1 ? append!(nachbar, [(pos[1],pos[2]-1)]) : nothing
        pos[2]+1 <= m ? append!(nachbar, [(pos[1],pos[2]+1)]) : nothing

        leftchild = nothing
        rightchild = nothing
        return new(pos, neighbours, leftchild, rightchild)
    end
end

