include("core.jl")
mutable struct Maze
    nodes::Matrix{Node}
    start::Node
    target::Node
    visual::Union{MazeViz, Nothing}
    path::Union{Vector{Node}, Nothing}
end

#recursive function for the matrix generation of the maze based on random depth-first search
function generate_matrix(current::Node, visited::Vector{Tuple{Int,Int}}, maze, size::Tuple{Int,Int})
    i,j = current.pos
    #check for reachable, not yet visited neighbours
    posibilities = neighbours(current,visited,size)
    if length(posibilities) == 0
        return nothing
    end
    #choose one at random
    rand_index = rand(1:length(posibilities))
    next = posibilities[rand_index]
    i_,j_ = next.pos
    
    push!(visited,next.pos)
    deleteat!(posibilities, rand_index)
    #adding reachability to node.connected of the respective nodes
    push!(maze[i,:][j].conected, next.pos)
    push!(maze[i_,:][j_].conected, current.pos)
    #traverse deeper
    generate_matrix(next, visited, maze, size)

    #if the backtracking reches this node again check for reachable nodes
    posibilities = neighbours(current,visited,size)
    if length(posibilities) == 0
        return nothing
    end
    #continue as above with new node
    rand_index = rand(1:length(posibilities))
    next = posibilities[rand_index]
    i_,j_ = next.pos

    push!(visited,next.pos)
    deleteat!(posibilities, rand_index)

    push!(maze[i,:][j].conected, next.pos)
    push!(maze[i_,:][j_].conected, current.pos)
    
    generate_matrix(next, visited, maze, size)

end





























































####################################################################################################
#######################################Propably useless#############################################
####################################################################################################
#=function maze_tree(width::Int, height::Int)
    #=nodes = []
    for n in 1:height
        for m in 1:width
            push!(nodes, Node((n,m)))
        end
    end
    rand_index = rand(1:length(nodes))=#

#chose a random start for maze genaration and add to visited nodes
    tree = Node((rand(1:width),rand(1:height)))
    visited::Vector{Tuple{Int,Int}} = [tree.pos]

    generate_tree(tree,visited,(width,height))

    return tree
end

#recursive function for the randomised depth-first tree-maze generation
#leftchild is generated during direct travering of the tree
#rightchild is generated after backtracking once a dead end had been reched
function generate_tree(tree::Node,visited::Vector{Tuple{Int,Int}},size::Tuple{Int,Int})::VectorUnion{Node,Nothing}
    #checking for direct neighbours
    posibilities = neighbours(tree,visited,size)
    if length(posibilities) == 0
        return tree
    end
    #choosing one at random
    rand_index = rand(1:length(posibilities))
    next = posibilities[rand_index]
    push!(visited,next.pos)
    deleteat!(posibilities, rand_index)

    #adding to the left of the tree
    tree.leftchild = generate_tree(next,visited,size)

    #will only be called once dead end had been reched 
    #checking for further neighbours
    posibilities = neighbours(tree,visited,size)
    if length(posibilities) == 0
        return tree
    end

    #checking at random
    rand_index = rand(1:length(posibilities))
    next = posibilities[rand_index]
    deleteat!(posibilities, rand_index)
    push!(visited,next.pos)
    #adding to the right of the tree
    tree.rightchild = generate_tree(next,visited,size)

    return tree
end=#