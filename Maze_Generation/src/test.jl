include("MazeGeneration.jl")

@testset "Maze" verbose=true begin
    @testset "Maze Generation" begin
        test_maze = maze(10,10)
        @test length(test_maze.nodes) == 100
        cohesive::Bool = true
        for node in test_maze
            length(node.conected) < 1 ? cohesive = false : nothing
        end
        @test cohesive == true
    end
    @testset "main" begin
        @testset "(inner) Constructor" begin
        sn = SnakeViz()
        @test size(sn.new_frame, 1) == 12 
        @test size(sn.new_frame, 2) == 12
        end 
    end
    #=
    @testset "solve" begin
        test_maze = maze(10,10)
        path = 
        @test length(test_maze.nodes) == 100
        cohesive::Bool = true
        for node in test_maze
            length(node.conected) < 1 ? cohesive = false : nothing
        end
        @test cohesive == true
    end
    =#
end

