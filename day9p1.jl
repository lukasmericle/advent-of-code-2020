function is2subsetsum(prev::Vector{Int}, this::Int)
    for (i,p)=enumerate(prev[1:end-1])
        #(((this - p) in prev[1:i-1]) || ((this - p) in prev[i+1:end])) && return true
        ((this - p) in prev[i+1:end]) && return true
    end
    return false
end
fname = "day9input.txt"
data = tryparse.(Int, readlines(fname))
i = 26
while (i <= length(data))
    global i
    !is2subsetsum(data[i-25:i-1], data[i]) && break
    i += 1
end
println(data[i])
