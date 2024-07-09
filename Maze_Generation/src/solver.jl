include("core.jl")
include("MazeGeneration.jl")

#= Falls keine Start- und Endpunkte vorgegeben werden, werden hier die Start und Endpunkte 
aus der Generierung des Labyrinths gewählt und an die Funktion zum Finden des kürzesten Weges übergeben
=#
function solve(maze::Maze)
    start = maze.start.pos
    target = maze.target.pos
    
    return solve(maze, start, target)
end

#=
Die Funktion solve findet den kürzesten Weg zwischen einem Start- und einem Enpunkt im Labyrinth über die rechte Hand Regel.
Sie setzt voraus, dass der Punkt exisrtiert und die Punkte verbunden sind.
maze::Maze = ist eine Labyrinth aus verbundenen Nodes, die ihre Position und ihre Verbindungen speichert.
start::Tuple ist der Startpunkt als Tuple
target::Tuple ist der Endpunkt als Tuple
Die Funktion schreibt den Pfad "path" in das Objekt maze und gibt den Pfad als Array aus Nodes zurück.
=#
function solve(maze::Maze, start::Tuple, target::Tuple)
    #Pfad zwischen Start und Endpunkt
    path = Vector{Node}()

    # Tuple in Node umwandeln, um auf die verbundenen Nodes zugreifen zu können
    pos = maze.nodes[start[1], start[2]]
    target = maze.nodes[target[1], target[2]]

    #zufälligen Starpunkt wählen
    next = rand(maze.start.conected)

    # Tuple in Node umwandeln, um auf die verbundenen Nodes zugreifen zu können
    new_pos = maze.nodes[next[1], next[2]]

    # Ausführen der rechten Hand Regel im Labyrinth und verfolgen des genommenen Weges, bis der Endpunkt erreicht ist.
    while pos != target
        # Entscheidung, ob gerade auf einem Hinweg, oder einem Rückweg aus einer Sackgasse.
        # Wenn wir auf dem Hinweg sind, wird die Position gespeichert, sonst wird sie gelöscht.
        if !in(pos, path)
            push!(path, pos)
        end
        if in(new_pos, path)
            pop!(path)
        end    

        #= Durch den Vergleich der Indizes von pos und new_pos wird die Bewegungsrichtung "Richting" definiert.
        In Abhängigkeit der Richtung wird dann die Node die rechts, geradeaus und links definiert.
        =#
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

        #= Nun wird in Reihnflge geschaut, ob rechts, geradeaus oder links möglich ist, indem die Verbidungsknoten von new_pos überprüft werden.
        Sollte der Knoten existieren, die pos zu new_pos und new_pos zum gerade gefundenen Knoten.
        Sonst haben wir eine Sackgasse erreicht und gehen wieder rückwärts, indem pos und new_pos tauschen.
        =# 
        if in(right, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[right[1], right[2]]
        elseif in(forward, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[forward[1], forward[2]]
        elseif in(left, new_pos.conected)
            pos, new_pos = new_pos, maze.nodes[left[1], left[2]]
        else
            pos, new_pos = new_pos, pos
            if pos != target
                # durch das Umdrehen wird die Logig des Pfadverfolgens durcheinander gebracht, weswegen die Position hier 
                #schon einmal eingespeichert wird, damit sie am Anfang der Schleife gelöscht und nicht gespeichert wird.
                push!(path, pos) 
            end
        end
    end
    # Da der Endknoten noch nicht im Pfad eingespeichert werden konnte, da abgebrochen wurde, muss der letzte Knoten noch eingespeichert werden.
    push!(path, pos)

    # Der Pfad wird im Objekt "maze", also dem Labyrinth gespeichert
    maze.path = path
    
    return path
end
