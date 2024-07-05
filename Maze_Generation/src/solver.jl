include("core.jl")
include("MazeGeneration.jl")

function solve(maze::Maze)
    path = Vector{Node}()
    pos = maze.start
    target = maze.target
    new_pos = rand(maze.start.conected)
    push!(path, pos)

    while pos != target
        if !in(path, new_pos)
            push!(path, new_pos)
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

        if in(right, new_pos.connected.pos)
            pos = new_pos
            for node in pos.connected
                if node.pos === right
                new_pos = node
                end
            end
        elseif in(forward, new_pos.connected.pos)
            pos = new_pos
            for node in pos.connected
                if node.pos === forward
                new_pos = node
                end
            end
        elseif in(left, new_pos.connected.pos)
            pos = new_pos
            for node in pos.connected
                if node.pos === left
                new_pos = node
                end
            end
        else
            path = path[1:end-2]
            new_pos = path[-1]
        end
    end
    
    return path
end

test = maze(3,3)
rand(test.start.conected)
solve(test)
