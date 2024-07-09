#Das ist ein Checkpoint

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
            #Wände schöner machen in gleicher for Schleife
            elseif j % 2 == 1 && i % 2 == 0
                matrix[j,i] = '-'
            elseif j % 2 == 0 && i % 2 == 1
                matrix[j,i] = '|'
            end
            #Start und Ziel einzeichnen 
            s1, s2 = maze.start.pos
            if j == s1*2 && i == s2*2
                matrix[j,i] = 'S'
            end
            t1, t2 = maze.target.pos
            if j == t1*2 && i == t2*2
                matrix[j,i] = 'T'
            end
        end
    end
    #Herausfinden wo Wände und wo conected, und je nachdem dann Wände rauslöschen
    for i in 1:n
        for j in 1:m
            if matrix[j,i] == 'o' || matrix[j,i] == 'S' || matrix[j,i] == 'T' 
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
    pfad = [node.pos for node in maze.path]
    while length(pfad) > 1
        if pfad[1] != pfad[2]
            a1, a2 = pfad[1]
            n1, n2 = pfad[2]
            akt_j = 2*a1
            akt_i = 2*a2
            next_j = 2*n1
            next_i = 2*n2
            if akt_i == next_i 
                if next_j < akt_j 
                    matrix[akt_j-1,akt_i] = '⇧'
                else 
                    matrix[akt_j+1,akt_i] = '⇩'
                end
            else
                if next_i < akt_i
                    matrix[akt_j,akt_i-1] = '⇦'
                else 
                    matrix[akt_j,akt_i+1] = '⇨'
                end
            end
        end
        popfirst!(pfad)
    end
    return MazeViz(matrix)
end


#=function show_path(visual::MazeViz, maze::Maze)
end=#

function print_maze(maze2::MazeViz)
    for i in 1:size(maze2.matrix, 1)
        println(String(maze2.matrix[i, :]))
    end
end


test = maze(10,10)
pfadii = solve(test)
#println(test.start)
#println(test.target)
#println(test.nodes)
#println(test.path)
print_maze(MazeViz(test, 10,10))
#println(test.path[1].pos)
#println(length(test.path))
#println(pfad[1])

#println(test)
#lösungi = solve(test)
#println(lösungi)
#=test = maze(3,3)

lösung = solve(test)
weg = show_path(test,labyrinth)
print_maze(d)=#
#testii = show_path(d, test)
#println(testii)
