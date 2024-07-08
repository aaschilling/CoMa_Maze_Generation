include("MazeGeneration.jl")
include("core.jl")
mutable struct MazeViz
    matrix::Matrix{Char}  
end

function MazeViz(maze::Maze, width::Int, height::Int)
    #Matrix mit richtiger Größe und alle als 'x' erstellen
    n = 2*width+1
    m = 2*height+1
    value = '+'
    matrix = fill(value, n, m)
    #Alle Matrixwerte die aus geradzahligen Ints bestehen werden von '+' zu 'o' -> sie sind die Punkte im Labyrinth
    # !Ränder und Wände schöner machen in gleicher for Schleife!
    for i in 2:n
        for j in 1:m
            if i % 2 == 0 && j % 2 == 0
                matrix[i,j] = 'o'
            end
        end
    end
    
    #println(maze.nodes[4,1].conected)
    #Herausfinden wo Wände und wo conected, und je nachdem dann Wände rauslöschen
    for i in 1:n
        for j in 1:m
            if matrix[i,j] == 'o'
                i_durch_2::Int = i/2                                                            #von width
                j_durch_2::Int = j/2                                                            #von height
                nachbarn::Vector{Tuple{Int, Int}} = maze.nodes[j_durch_2, i_durch_2].conected
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

function print_maze(maze2::MazeViz)
    for i in 1:size(maze2.matrix, 1)
        println(String(maze2.matrix[i, :]))
    end
end


test = maze(2,4)
println(test)
d = MazeViz(test , 2 , 4)
print_maze(d)
