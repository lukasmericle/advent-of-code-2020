function make_grid(rows::Vector{String})
    grid = Matrix{Char}(undef, length(rows), length(rows[1]))
    for (i,row)=enumerate(rows)
        grid[i,:] .= [c for c=row]
    end
    grid
end
(Base.:%)(ij::CartesianIndex, mat::Matrix{T}) where T = CartesianIndex(ij[1], mod(ij[2]-1, size(mat, 2))+1)
fname = "day3input.txt"
grid = make_grid(readlines(fname))
ij = CartesianIndex(1, 1)
n = 0
while true
    global ij, n
    ij += CartesianIndex(1, 3)
    (ij[1] == (size(grid, 1) + 1)) && break
    ij %= grid
    (grid[ij] == '#') && (n += 1)
end
println(n)
