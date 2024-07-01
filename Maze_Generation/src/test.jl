@testset "Snake" verbose=true begin
    @testset "greet" begin
        @test greet() == "Hello, World!"
    end
    @testset "main" begin
        @testset "(inner) Constructor" begin
        sn = SnakeViz()
        @test size(sn.new_frame, 1) == 12 
        @test size(sn.new_frame, 2) == 12
        end 
    end

    #Check the print of greet()
    

end