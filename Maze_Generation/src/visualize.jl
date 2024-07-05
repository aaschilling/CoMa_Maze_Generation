mutable struct MazeViz

    function MazeViz(height::Int, width::Int)
        m = 2*height+1
        n = 2*width+1
        value = 'x'
        Matrix = fill(value, m, n)
        return Matrix
    end
end

d = MazeViz(3,3)
