include("core.jl")
include("MazeGeneration.jl")

function solve(maze::Maze)
    path = Vector{Node}()
    start = maze.start.pos
    ziel = maze.target.pos
    pos = maze.nodes[start[2], start[1]]
    target = maze.nodes[ziel[2], ziel[1]]
    next = rand(maze.start.conected)
    new_pos = maze.nodes[next[2], next[1]]

    while pos != target
        if !in(pos, path)
            push!(path, pos)
        elseif in(new_pos, path)
            pop!(path)
        end    

        if pos.pos[1] != new_pos.pos[1]
            richtung = pos.pos[1] - new_pos.pos[1] 
            if richtung < 0
                right = (new_pos.pos[1], pos.pos[2] - 1)
                forward = (new_pos.pos[1]+1, pos.pos[2])
                left = (new_pos.pos[1], pos.pos[2] + 1)
            else
                right = (new_pos.pos[1], pos.pos[2] + 1)
                forward = (new_pos.pos[1]-1, pos.pos[2])
                left = (new_pos.pos[1], pos.pos[2] - 1)
            end
        end
        if pos.pos[2] != new_pos.pos[2]
            richtung = pos.pos[2] - new_pos.pos[2] 
            if richtung < 0
                right = (pos.pos[1] + 1 , new_pos.pos[2])
                forward = (pos.pos[1], new_pos.pos[2]+1)
                left = (pos.pos[1] - 1, new_pos.pos[2]) 
            else
                right = (pos.pos[1] - 1 , new_pos.pos[2])
                forward = (pos.pos[1], new_pos.pos[2]-1)
                left = (pos.pos[1] + 1, new_pos.pos[2]) 
            end
        end

        if in(right, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[right[2], right[1]]
        elseif in(forward, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[forward[2], forward[1]]
        elseif in(left, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[left[2], left[1]]
        else
            pos, new_pos = new_pos, pos
        end
    end
    push!(path, pos)
    return path
end

test = maze(3,3)
println(test.nodes)
println(test.start)
println(test.target)
println(solve(test))