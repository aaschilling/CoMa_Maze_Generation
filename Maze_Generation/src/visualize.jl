#Das ist ein Checkpoint

#include("MazeGeneration.jl")
#include("core.jl")
#include("solver.jl")

function MazeViz(maze::Maze)
    width = length(maze.nodes[1,:])
    height = length(maze.nodes[:,1])
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
            #Außenwände shöner in dem sie die jeweilige Striche sind
            if j == 1 && i != 1 && i != n
                matrix[j,i] = '-'
            elseif j == m && i != 1 && i != n
                matrix[j,i] = '-'
            elseif i == 1 && j != 1 && j!= m
                matrix[j,i] = '|'
            elseif i == n && j != 1 && j!= m
                matrix[j,i] = '|'
            #Innenwände auch schöner machen
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
                nachbarn::Vector{Tuple{Int, Int}} = copy(maze.nodes[j_durch_2, i_durch_2].conected)
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
    #den Pfad der in solve gefunden wird einzeichnen
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
    maze.visual = MazeViz(matrix)
    #return MazeViz(matrix)
end

#überladen der show Funktion
function Base.show(io::IO, maze::Maze)
    maze2 = maze.visual
    for i in 1:size(maze2.matrix, 1)
        println(io, String(maze2.matrix[i, :]))
    end
end


##############
#test = maze(5,5)
#pfadii = solve(test)
#MazeViz(test)
#print_maze(MazeViz(test))
#println(test.start)
#println(test.target)
#println(test.nodes)
#println(test.path)
#Base.show(MazeViz(test))
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
