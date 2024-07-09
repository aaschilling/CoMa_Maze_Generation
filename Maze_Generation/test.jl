include("maze.jl")
using Test

@testset "Maze" verbose=true begin
    @testset "Maze Generation" begin
        test_maze = maze(10,10)
        print(test_maze.nodes)
        @test length(test_maze.nodes) == 100
        cohesive::Bool = true
        for node in test_maze.nodes
            length(node.conected) < 1 ? cohesive = false : nothing
            length(node.conected) < 1 ? println(node) : nothing
        end
        @test cohesive == true
    end

    #=@testset "solve" begin
        test_maze = maze(10,10)
        solve(test_maze)

        @test length(test_maze.path) <= 100
        cohesive::Bool = true
        for i in range(2, 100)
            first = test_maze.nodes[i-1]
            second = test_maze.nodes[i]
            in(second.pos, first.conected) ? cohesive = false : nothing
            length(node.conected) < 1 ? cohesive = false : nothing
        end
        @test cohesive == true
        has_duplicates = length(test_maze.path) != length(unique(test_maze.path))
        @test has_duplicates == false
    end =#
end