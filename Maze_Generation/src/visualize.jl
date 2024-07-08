include("MazeGeneration.jl")
include("core.jl")
mutable struct MazeViz
    matrix::Matrix{Char}  
end

function MazeViz(maze::Maze, height::Int, width::Int)
    #Matrix mit richtiger Größe und alle als 'x' erstellen
    n = 2*width+1
    m = 2*height+1
    value = '+'
    matrix = fill(value, m, n)
    #Alle Matrixwerte die aus geradzahligen Ints bestehen werden von '+' zu 'o' -> sie sind die Punkte im Labyrinth
    # !Ränder und Wände schöner machen in gleicher for Schleife!
    for i in 1:n
        for j in 1:m
            if i % 2 == 0 && j % 2 == 0
                matrix[j,i] = 'o'
            end
        end
    end
    
    #println(maze.nodes[1,4].conected)
    #Herausfinden wo Wände und wo conected, und je nachdem dann Wände rauslöschen
    for i in 1:n
        for j in 1:m
            if matrix[j,i] == 'o'
                i_durch_2::Int = i/2                                                            #von width
                j_durch_2::Int = j/2                                                            #von height
                nachbarn::Vector{Tuple{Int, Int}} = maze.nodes[j_durch_2, i_durch_2].conected
                if typeof(nachbarn) != Nothing
                    while length(nachbarn) >= 1
                        (y,x) = nachbarn[1]
                        x *= 2
                        y *= 2
                        if i == x 
                            if y < j 
                                matrix[j-1,i] = ' '
                            else 
                                matrix[j+1,i] = ' '
                            end
                        else
                            if x < i
                                matrix[j,i-1] = ' '
                            else 
                                matrix[j,i+1] = ' '
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
d = MazeViz(test , 2,4)
print_maze(d)
