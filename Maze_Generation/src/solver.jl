include("core.jl")
include("MazeGeneration.jl")

function solve(maze::Maze)
    path::Vector{Node}
    start = maze.start.pos
    target = maze.target.pos
    pos = start
    new_pos = rand(maze.start.conected)
    push!(path, pos)

    while pos != target
        while in(new_pos, path)
            new_pos = path[-2]
            pop!(path)
        end

        push!(path, new_pos)

        if pos[1] != new_pos[1]
            richtung = pos[1] - new_pos[1] 
            if richtung < 0
                right = (new_pos[1], pos[2] - 1)
                forward = (new_pos[1]+1, pos[2])
                left = (new_pos[1], pos[2] + 1)
            else
                right = (new_pos[1], pos[2] + 1)
                forward = (new_pos[1]-1, pos[2])
                left = (new_pos[1], pos[2] - 1)
            end
        end
        if pos[2] != new_pos[2]
            richtung = pos[2] - new_pos[2] 
            if richtung < 0
                right = (pos[1] + 1 , new_pos[2])
                forward = (pos[1], new_pos[2]+1)
                left = (pos[1] - 1, new_pos[2]) 
            else
                right = (pos[1] - 1 , new_pos[2])
                forward = (pos[1], new_pos[2]-1)
                left = (pos[1] + 1, new_pos[2]) 
            end
        end

        if in(right, new_pos.connected)
            pos = new_pos
            new_pos = right
        elseif in(forward, new_pos.connected)
            pos = new_pos
            new_pos = forward
        elseif in(left, new_pos.connected)
            pos = new_pos
            new_pos = forward
        else
            pos = pos
            path = path[1:end-2]
            new_pos = path[-1]
        end
    end
    return path
end

test = maze(3,3)
solve(test)
