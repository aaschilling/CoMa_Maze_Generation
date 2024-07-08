include("MazeGeneration.jl")
include("core.jl")
include("solver.jl")
mutable struct MazeViz
    matrix::Matrix{Char}  
end

function MazeViz(maze::Maze, height::Int, width::Int)
    #Matrix mit richtiger Größe und alle als '+' erstellen
    n = 2*width+1
    m = 2*height+1
    matrix = fill('+', m, n)
    for i in 1:n
        for j in 1:m
            #Alle Matrixwerte die aus geradzahligen Ints bestehen werden von '+' zu 'o' -> sie sind die Punkte im Labyrinth
            if i % 2 == 0 && j % 2 == 0
                matrix[j,i] = 'o'
            end
            #Außenwände shöner in dem sie jeweilige Striche sind
            if j == 1 && i != 1 && i != n
                matrix[j,i] = '-'
            elseif j == m && i != 1 && i != n
                matrix[j,i] = '-'
            elseif i == 1 && j != 1 && j!= m
                matrix[j,i] = '|'
            elseif i == n && j != 1 && j!= m
                matrix[j,i] = '|'
            end
            # !Wände schöner machen in gleicher for Schleife!

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
lösungi = solve(test)
println(lösungi)
d = MazeViz(test , 2,4)
print_maze(d)
