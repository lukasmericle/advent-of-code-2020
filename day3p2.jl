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
ns = Int[]
for dir=[CartesianIndex(i, j) for (i,j)=[(1,1), (1,3), (1,5), (1,7), (2,1)]]
    ij = CartesianIndex(1, 1)
    n = 0
    while true
        ij += dir
        (ij[1] > size(grid, 1)) && break
        ij %= grid
        (grid[ij] == '#') && (n += 1)
    end
    push!(ns, n)
end
println(prod(ns))
