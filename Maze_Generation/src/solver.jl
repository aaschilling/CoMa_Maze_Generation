include("core.jl")
include("MazeGeneration.jl")

function solve(maze::Maze)
    start = maze.start.pos
    target = maze.target.pos
    
    return solve(maze, start, target)
end

function solve(maze::Maze, start::Tuple, target::Tuple)
    path = Vector{Node}()
    pos = maze.nodes[start[1], start[2]]
    target = maze.nodes[target[1], target[2]]
    next = rand(maze.start.conected)
    new_pos = maze.nodes[next[1], next[2]]

    while pos != target
        if !in(pos, path)
            push!(path, pos)
        end
        if in(new_pos, path)
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
            pos, new_pos = new_pos, maze.nodes[right[1], right[2]]
        elseif in(forward, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[forward[1], forward[2]]
        elseif in(left, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[left[1], left[2]]
        else
            pos, new_pos = new_pos, pos
            push!(path, pos)
        end
    end
    push!(path, pos)
    maze.path = path
    return path
end