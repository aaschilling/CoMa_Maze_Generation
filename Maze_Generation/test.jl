include("maze.jl")
using Test

@testset "Maze" verbose=true begin
    # Testlabyrinthe, einmal quadratisch, immer 100 Felder, quadratisch rechteckig.
    test_mazes = [(10,10), (5, 20), (20, 5)]

    #=Testen der MazeGeneration.
    Es wird getested ob das Labyrinth die richtige Größe hat und ob die Nodes zusammenhängend sind, 
    indem geschaut wird, dass das Feld in den Nodes die die Verbidnugn anzeigt nicht leer ist.
    =#
    @testset "Maze Generation" begin
        for i in test_mazes
            test_maze = maze(i[1],i[2])
            @test length(test_maze.nodes) == i[1]*i[2]
            cohesive::Bool = true
            for node in test_maze.nodes
                length(node.conected) < 1 ? cohesive = false : nothing
            end
            @test cohesive == true
        end
    end

    #=Testen der solve Funktion.
    Es wird getestet, dass der Pfad nicht größer ist als die Anzahl der möglichen Nodes, 
    dass die Nodes verbunden sind, für jede Node ab der zweiten im path geschaut wird, ob die Node in den Verbundenen der vorherigen enthalten ist
    und der Pfad keine Umwege nimmt, indem auf Duplikate durch vergleich der Längen der Listen nach Anwendung der unique Funktion überprüft wird 
    =#
    @testset "solve" begin
        for i in test_mazes
            test_maze = maze(i[1],i[2])

            @test length(test_maze.path) <= i[1]*i[2]
            cohesive::Bool = true
            for i in range(2, size(test_maze.path, 1))
                first_node = test_maze.path[i-1]
                second_node = test_maze.path[i]
                length(first_node.conected) < 1 ?  cohesive = false : nothing
                !in(second_node.pos, first_node.conected) ?  cohesive = false : nothing
            end
            @test cohesive == true
            has_duplicates = length(test_maze.path) != length(unique(test_maze.path))
            @test has_duplicates == false
        end
    end
end