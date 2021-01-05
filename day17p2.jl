Cell = CartesianIndex{4}
function read_input(fname::AbstractString)
    lines = readlines(fname)
    sites = Cell[]
    for (i,line)=enumerate(lines)
        for (j,pos)=enumerate(line)
            pos === '#' && push!(sites, CartesianIndex(i,j,0,0))
        end
    end
    sites
end
function neighbors(site::Cell)
    nn = Cell[]
    for i=-1:1
        for j=-1:1
            for k=-1:1
                for l=-1:1
                    !(i === 0 && j === 0 && k === 0 && l === 0) && push!(nn, site + CartesianIndex(i,j,k,l))
                end
            end
        end
    end
    nn
end
function count!(d::Dict{T, Int}, v::Vector{T}) where T
    for x=v
        try
            d[x] += 1
        catch e
            d[x] = 1
        end
    end
    d
end
function count(v::Vector{T}) where T
    d = Dict{T, Int}()
    count!(d, v)
    d
end
function update(sites::Vector{Cell})
    neighbor_counter = Dict{Cell, Int}()
    for site=sites
        count!(neighbor_counter, neighbors(site))
    end
    new_sites = Cell[]
    for (site,n_neighbors)=neighbor_counter
        if (n_neighbors === 3) || ((n_neighbors === 2) && in(site, sites))
            push!(new_sites, site)
        end
    end
    new_sites
end
fname = "day17input.txt"
sites = read_input(fname)
num_steps = 6
for i=1:num_steps
    global sites
    sites = update(sites)
    (length(sites) === 0) && break
end
println(length(sites))
