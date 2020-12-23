Cell = Union{Bool,Missing}
istrue(x) = !ismissing(x) && x
isfalse(x) = !ismissing(x) && !x
function neighborhood(grid::Matrix{Cell}, ij::CartesianIndex)
    dirs = [CartesianIndex(-1,-1),
            CartesianIndex(-1,0),
            CartesianIndex(-1,1),
            CartesianIndex(0,-1),
            CartesianIndex(0,1),
            CartesianIndex(1,-1),
            CartesianIndex(1,0),
            CartesianIndex(1,1)]
    nbhd = Array{Cell}(undef, 8)
    fill!(nbhd, missing)
    let (n,m) = size(grid)
        for (i,dir)=enumerate(dirs)
            iijj = ij + dir
            while (1 <= iijj[1] <= n) && (1 <= iijj[2] <= m)
                if istrue(grid[iijj])
                    nbhd[i] = true
                    break
                elseif ismissing(grid[iijj])
                    break
                end
                iijj += dir
            end
        end
    end
    nbhd
end
function evolve(grid::Matrix{Cell})
    new_grid = copy(grid)
    for i=1:size(grid, 1)
        for j=1:size(grid, 2)
            ij = CartesianIndex(i,j)
            nhbd = neighborhood(grid, ij)
            if ismissing(grid[ij]) && (count(istrue.(nhbd)) == 0)
                new_grid[ij] = true
            elseif istrue(grid[ij]) && (count(istrue.(nhbd)) >= 5)
                new_grid[ij] = missing
            end
        end
    end
    new_grid
end
fname = "day11input.txt"
rows = readlines(fname)
grid = Array{Cell}(undef, length(rows), length(rows[1]))
for (i,row)=enumerate(rows)
    global grid
    for j=1:length(row)
        grid[i,j] = (row[j] == '.') ? false : missing
    end
end
while true
    global grid
    new_grid = evolve(grid)
    all(grid .=== new_grid) && break
    grid = new_grid
end
println(count(istrue.(grid)))
