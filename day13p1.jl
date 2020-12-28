fname = "day13input.txt"
rows = readlines(fname)
first_time = tryparse(Int, rows[1])
bus_ids = filter(x -> !isnothing(x), tryparse.(Int, split(rows[2], ",")))
diffs = similar(bus_ids)
for (i,bus_id)=enumerate(bus_ids)
    n_loops = ceil(Int, first_time / bus_id)
    diffs[i] = n_loops * bus_id - first_time
end
mindiff, idx = findmin(diffs)
println(mindiff * bus_ids[idx])
