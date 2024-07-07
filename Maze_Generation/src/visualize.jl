include("MazeGeneration.jl")
include("core.jl")
mutable struct MazeViz
    matrix::Matrix{Char}  
end

function MazeViz(maze::Maze, height::Int, width::Int)
    #Matrix mit richtiger Größe und alle als 'x' erstellen
    m = 2*height+1
    n = 2*width+1
    value = 'x'
    matrix = fill(value, m, n)
    #Alle Matrixwerte die aus geradzahligen Ints bestehen werden von 'x' zu 'o' -> sie sind die Punkte im Labyrinth
    for i in 1:m
        for j in 1:n
            if i % 2 == 0 && j % 2 == 0
                matrix[i,j] = 'o'
            end
        end
    end
    #Herausfinden wo Wände und wo conected, und je nachdem dann Wände rauslöschen
    for i in 1:m
        for j in 1:n
            if matrix[i,j] == 'o'
                i_durch_2::Int = i/2
                j_durch_2::Int = j/2
                nachbarn::Vector{Tuple{Int, Int}} = maze.nodes[i_durch_2, j_durch_2].conected
                if typeof(nachbarn) != Nothing
                    while length(nachbarn) >= 1
                        (x,y) = nachbarn[1]
                        x *= 2
                        y *= 2
                        if i == x 
                            if y < j 
                                matrix[i, j-1] = ' '
                            else 
                                matrix[i, j+1] = ' '
                            end
                        else
                            if x < i
                                matrix[i-1, j] = ' '
                            else 
                                matrix[i+1, j] = ' '
                            end
                        end
                        popfirst!(nachbarn)
                    end
                end
            end
        end
    end
    return MazeViz(matrix)
end

function print_maze(maze::MazeViz)
    for i in 1:size(maze.matrix, 1)
        println(String(maze.matrix[i, :]))
    end
end


test = maze(3,3)
d = MazeViz(test,3,3)
print_maze(d)
