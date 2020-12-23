fname = "day10input.txt"
data = tryparse.(Int, readlines(fname))
sort!(data)
data = vcat([0], data, [data[end]+3])
diffs = data[2:end] .- data[1:end-1]
println(count(diffs .== 1) * count(diffs .== 3))
