Cell = Union{Bool,Missing}
istrue(x) = !ismissing(x) && x
isfalse(x) = !ismissing(x) && !x
function neighborhood(grid::Matrix{Cell}, ij::CartesianIndex)
    let (i,j) = Tuple(ij), (n,m) = size(grid)
        grid[max(1,i-1):min(i+1,n),max(j-1,1):min(j+1,m)]
    end
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
